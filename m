Return-Path: <stable+bounces-215077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAN8NjHwiWn4EQAAu9opvQ
	(envelope-from <stable+bounces-215077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:33:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B61106D5
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDC723003BF1
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E3736828A;
	Mon,  9 Feb 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F9Lz5+2X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51E285060;
	Mon,  9 Feb 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647596; cv=none; b=orL7pi1vccJA6e+u7WZjY/tVbrdvsItz27MUgQxpAB6lHDz35KmhvbPm5+H2f8aaIkZwPkVKUXGxfbAKPkDa2H8Z11YInrHytD+kKzv5x4i3biMOvWMRQTzSVehlqBkZJBdhSTuQHYQR+LiM3L/X/Kh5PohVSDvAMVAofvqwqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647596; c=relaxed/simple;
	bh=jiaKetmqMkW3sklFtmhEhf/EQDkEA4l3OdLA+zdNRyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cC+Xx6Nw10VSt3xF9s5QULBGmIaO6ADOB+Zr5Tr+fTY8E4WPPxa2XfaQWcOJ4Jc3wFydLm7/cL+s2qb3aFDwah2qP3G+NZwJW5OtDXuSZPPYjSpRFU7kh1Ayk1KdvRaBGtSdogrm6IlQCHr8uZihKRx1X9yoN6ZRvfNG0UR5H4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F9Lz5+2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEDEC116C6;
	Mon,  9 Feb 2026 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647596;
	bh=jiaKetmqMkW3sklFtmhEhf/EQDkEA4l3OdLA+zdNRyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9Lz5+2XMxygeSmepZpa71k/nEVSSDUU8PV0sO8AR81HxLP+sseCHl5b0VMDzOaau
	 aOwiFh0RiNCj47sEvdoh9BCYURyafov5PUC9imspnD3b9DwttUfMjE6yhBUsmiS8FL
	 YYCyLzik4ZR38R7rwz5ZByKzRWH4+md9oIkRLInI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 147/175] net: ethernet: adi: adin1110: Check return value of devm_gpiod_get_optional() in adin1110_check_spi()
Date: Mon,  9 Feb 2026 15:23:40 +0100
Message-ID: <20260209142325.791894729@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215077-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A0B61106D5
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 78211543d2e44f84093049b4ef5f5bfa535f4645 ]

The devm_gpiod_get_optional() function may return an ERR_PTR in case of
genuine GPIO acquisition errors, not just NULL which indicates the
legitimate absence of an optional GPIO.

Add an IS_ERR() check after the call in adin1110_check_spi(). On error,
return the error code to ensure proper failure handling rather than
proceeding with invalid pointers.

Fixes: 36934cac7aaf ("net: ethernet: adi: adin1110: add reset GPIO")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20260202040228.4129097-1-nichen@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/adi/adin1110.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 30f9d271e5953..71a2397edf2bb 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -1089,6 +1089,9 @@ static int adin1110_check_spi(struct adin1110_priv *priv)
 
 	reset_gpio = devm_gpiod_get_optional(&priv->spidev->dev, "reset",
 					     GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(&priv->spidev->dev, PTR_ERR(reset_gpio),
+				     "failed to get reset gpio\n");
 	if (reset_gpio) {
 		/* MISO pin is used for internal configuration, can't have
 		 * anyone else disturbing the SDO line.
-- 
2.51.0




