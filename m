Return-Path: <stable+bounces-213928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D6FDNNkg2l1mQMAu9opvQ
	(envelope-from <stable+bounces-213928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:25:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E688E87D3
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63CE73111DB9
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9EB421F03;
	Wed,  4 Feb 2026 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L/Fl3VOk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FE421EFE;
	Wed,  4 Feb 2026 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217984; cv=none; b=SrEk5sd3jgZf21M/gW0UPWTwmYsh060Y6YOchHy04fgBCAVkppudDYs0KQypvSKiMumXQJzLL1GULsif1nXVVnIVBJ18mDbDYW8pbkf1GFcfLLfAPGw7dQqebcfUfmEo3epiRl3kFUsY/618rcAAkOhgtNjyARJ33j+NHHowu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217984; c=relaxed/simple;
	bh=GroNBRWxD24o2ms0whYPG66TchxBxNUZ1GG0Qqkpmug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeB3lXa8BKc54zaIp+AX0PiltnvH3dyhwr/bQCzFwhbUPfuouAvhchB6//PPcBuApYvgsfN4Mus2Zd93SDYOgVJdqNqTYbE5aLdfAoSEQqjm/9zluP/pL5X14zGTORYhIiCPIQs6lkbOZcQ3SM10cuRBV9Oz1gaCTsoccbulKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L/Fl3VOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D0AC4CEF7;
	Wed,  4 Feb 2026 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217983;
	bh=GroNBRWxD24o2ms0whYPG66TchxBxNUZ1GG0Qqkpmug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/Fl3VOkCjbHQf0sAyuNRQc2NM329DIz25D6K9NLNtV1Yepqa/bZX4GmwnFG5Xjfi
	 22NyMVLBK/KlN0xLXo7AsodUo60ym94cRet/Kn/4Dyt7ND+dnpW/aLBcEBG15YUTPz
	 S+r+NYlG4Cm+Y7ncGQbHSfa01FwrByWXHY0M5tJ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Andreas=20K=C3=BCbrich?= <andreas.kuebrich@spektra-dresden.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 160/280] iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl
Date: Wed,  4 Feb 2026 15:38:54 +0100
Message-ID: <20260204143915.385199183@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213928-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 9E688E87D3
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kübrich, Andreas <andreas.kuebrich@spektra-dresden.de>

commit 441ac29923c9172bc5e4b2c4f52ae756192f5715 upstream.

The chip info for this variant (I2C, four channels, 14 bit, internal
reference) seems to have been left out due to oversight, so
ad5686_chip_info_tbl[ID_AD5695R] is all zeroes. Initialisation of an
AD5695R still succeeds, but the resulting IIO device has no channels and no
/dev/iio:device* node.

Add the missing chip info to the table.

Fixes: 4177381b4401 ("iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support")
Signed-off-by: Andreas Kübrich <andreas.kuebrich@spektra-dresden.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/ad5686.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -427,6 +427,12 @@ static const struct ad5686_chip_info ad5
 		.num_channels = 4,
 		.regmap_type = AD5686_REGMAP,
 	},
+	[ID_AD5695R] = {
+		.channels = ad5685r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 4,
+		.regmap_type = AD5686_REGMAP,
+	},
 	[ID_AD5696] = {
 		.channels = ad5686_channels,
 		.num_channels = 4,



