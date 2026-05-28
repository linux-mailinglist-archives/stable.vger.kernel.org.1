Return-Path: <stable+bounces-255539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEDZNIOiGGrClggAu9opvQ
	(envelope-from <stable+bounces-255539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE95F8359
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE312303D2E7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD09D409638;
	Thu, 28 May 2026 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b2/DFmk0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C0339866;
	Thu, 28 May 2026 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999195; cv=none; b=m3zltzh2gMUrJeoW+zeZ62pIKWIMtiaMj/Ty004hdQ2k+or4n5T5btWG83YdHWhyVp9staE0znA2rKMlNhVJAY67KQppaqD46KhFckzqfiQtLBhGkr9xWxoWsWzrAK3+G1gcJiHr6sZN0ZWggodMTRGGIyWAA7Ng6OLJ5rs4Z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999195; c=relaxed/simple;
	bh=6l05XjKACCtPeF+tnEC3WEp///8bwF+G3JZVpBzrcYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUxs+Vtgha5hi3P0cCfjmKYpMnu73qh2YiJjavxJVXJ57jZsBLhrwv7INRadBqEhc8JB1lwhwNzlpAk6Jqlu/seYHHSQxXTuXGI+wp17qSxyi9ika/JRj4uIx/8DLbJE2+xXVJ9e6vRfXqpvHUl1vx/SlHay0XjgcEF4dsQuvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2/DFmk0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3351F000E9;
	Thu, 28 May 2026 20:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999194;
	bh=oEMYZprbj/WtWnmKgbd4SiH+wjemdWYY/HD9uGrlfT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2/DFmk0B2yo0Ry8pkOHwnxLnKNoD4iHkxTw92rALo75Xn/7FdHV2iC7SN3bhzZ6u
	 q5lXxyW9W+VIrZTOr2iV9xLp55tDcqeCX9dC6nUDXu7hwYHopDkdbNoKFVpXI+5W4x
	 1D7A4s3oZ8krJ/83ou41SiU6ikfc0WEJ7hwCBeZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 443/461] ASoC: cs-amp-lib: Fix wrong sizeof() in _cs_amp_set_efi_calibration_data()
Date: Thu, 28 May 2026 21:49:32 +0200
Message-ID: <20260528194700.354430025@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255539-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,cirrus.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 43AE95F8359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 67a52d3ebb5a0ae0c0e23ffa99470d9463179c9f ]

When calculating data->count replace the incorrect sizeof(data) with use
of struct_offset().

The faulty sizeof(data) was incorrectly calculating the size of the
pointer instead of the size of the struct pointed to. As it happens, both
values are 8 on a 64-bit CPU. In the unlikely event of using this code on
a 32-bit CPU the number of available bytes would be calculated 4 larger
than is actually available.

Instead of changing to sizeof(*data) it has been replaced by
struct_offset() because it has better chance of detecting these sorts of
typos. Also the offset of the data[] array is actually what we want to know
here anyway.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2b62e66626f0 ("ASoC: cs-amp-lib: Add function to write calibration to UEFI")
Link: https://patch.msgid.link/20260521122511.987322-2-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs-amp-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 8b131975143d1..75baeaf64afd0 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -500,7 +500,7 @@ static int _cs_amp_set_efi_calibration_data(struct device *dev, int amp_index, i
 	 * must be set.
 	 */
 	if (data->count == 0)
-		data->count = (data->size - sizeof(data)) / sizeof(data->data[0]);
+		data->count = (data->size - struct_offset(data, data)) / sizeof(data->data[0]);
 
 	if (amp_index < 0) {
 		/* Is there already a slot for this target? */
-- 
2.53.0




