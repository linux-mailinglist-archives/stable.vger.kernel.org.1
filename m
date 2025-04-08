Return-Path: <stable+bounces-131501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFF0A80AFA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C5E4E7338
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3972226FA7B;
	Tue,  8 Apr 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gevjw4EO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E3C280A4D;
	Tue,  8 Apr 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116570; cv=none; b=Fn1EJ0i5aP3mgrCHFJ7pNWoOIRp99Ls7WbBrqL06yVF2pMtJpcReBnrqEReQz38+d8CE6oDyK0kpWkrACf3YmMOxuLZt8pPKiLN0sEHUgoj0qL2MQo9imN1ozdja7xg9v3Fef45bTzkZgJbDK0xWWfLrPzXSbur5f1lZy2rPB54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116570; c=relaxed/simple;
	bh=tWtnSqWtHOVx02zjR0kUpEyFTcD4sLU1URTWMPallAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOtLMs+tLOQ57jWEiS5Be943jP82OxdELpKOjq8WQSjw/dEa2QNnxAqGWdUw8YcH2vKnmCd7lBE539EjwbfrpfnpdGN2iZIqmJcJjXCkxSunxtE8A773USMyR+PgAAJA3iKW5F/8NN3qcpUg3gtVAyMzlyfZKRyQDxIdT/ZKLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gevjw4EO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9BFC4CEE5;
	Tue,  8 Apr 2025 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116569;
	bh=tWtnSqWtHOVx02zjR0kUpEyFTcD4sLU1URTWMPallAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gevjw4EO0ti8FPB6HL9VagdwMKmrPG5zybCr3+Y9k7hpui1MtvVWAvTEN2BDD2CKi
	 ap0zIVxnOQTXwacuTtizpivjr2fZewsQj17zbypLOEBAmcSGoc86LpH1b5SeQsPt3p
	 5duV4yKeR6ckiU3OISrS5FjxtTm5C3Wy+beEN0tk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 189/423] iio: adc: ad7124: Fix comparison of channel configs
Date: Tue,  8 Apr 2025 12:48:35 +0200
Message-ID: <20250408104850.141119165@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 05a5d874f7327b75e9bc4359618017e047cc129c ]

Checking the binary representation of two structs (of the same type)
for equality doesn't have the same semantic as comparing all members for
equality. The former might find a difference where the latter doesn't in
the presence of padding or when ambiguous types like float or bool are
involved. (Floats typically have different representations for single
values, like -0.0 vs +0.0, or 0.5 * 2² vs 0.25 * 2³. The type bool has
at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
true, but memcmp finds a difference.)

When searching for a channel that already has the configuration we need,
the comparison by member is the one that is needed.

Convert the comparison accordingly to compare the members one after
another. Also add a static_assert guard to (somewhat) ensure that when
struct ad7124_channel_config::config_props is expanded, the comparison
is adapted, too.

This issue is somewhat theoretic, but using memcmp() on a struct is a
bad pattern that is worth fixing.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/20250303114659.1672695-13-u.kleine-koenig@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7124.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 8d94bc2b1cac3..30a7392c4f8b9 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -147,7 +147,11 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	bool live;
 	unsigned int cfg_slot;
-	/* Following fields are used to compare equality. */
+	/*
+	 * Following fields are used to compare for equality. If you
+	 * make adaptations in it, you most likely also have to adapt
+	 * ad7124_find_similar_live_cfg(), too.
+	 */
 	struct_group(config_props,
 		enum ad7124_ref_sel refsel;
 		bool bipolar;
@@ -334,15 +338,38 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 								  struct ad7124_channel_config *cfg)
 {
 	struct ad7124_channel_config *cfg_aux;
-	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = sizeof_field(struct ad7124_channel_config, config_props);
+	/*
+	 * This is just to make sure that the comparison is adapted after
+	 * struct ad7124_channel_config was changed.
+	 */
+	static_assert(sizeof_field(struct ad7124_channel_config, config_props) ==
+		      sizeof(struct {
+				     enum ad7124_ref_sel refsel;
+				     bool bipolar;
+				     bool buf_positive;
+				     bool buf_negative;
+				     unsigned int vref_mv;
+				     unsigned int pga_bits;
+				     unsigned int odr;
+				     unsigned int odr_sel_bits;
+				     unsigned int filter_type;
+			     }));
+
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
 		if (cfg_aux->live &&
-		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
+		    cfg->refsel == cfg_aux->refsel &&
+		    cfg->bipolar == cfg_aux->bipolar &&
+		    cfg->buf_positive == cfg_aux->buf_positive &&
+		    cfg->buf_negative == cfg_aux->buf_negative &&
+		    cfg->vref_mv == cfg_aux->vref_mv &&
+		    cfg->pga_bits == cfg_aux->pga_bits &&
+		    cfg->odr == cfg_aux->odr &&
+		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
+		    cfg->filter_type == cfg_aux->filter_type)
 			return cfg_aux;
 	}
 
-- 
2.39.5




