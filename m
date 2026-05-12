Return-Path: <stable+bounces-245874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE9XCbdmA2qZ5gEAu9opvQ
	(envelope-from <stable+bounces-245874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:43:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C447525FBD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1843C3017D3E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1553DC86D;
	Tue, 12 May 2026 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x5+1h81j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0FB385D85;
	Tue, 12 May 2026 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607777; cv=none; b=iO3mPR2+in5Knrrva5R0DO7Kko9fynVkHXXIArejJkv3HeKDbthLNwXLomJz4FONPa8cT+QDjb9bK0bgtx3tkcmHiKjfTPl/AMhC6eqimJSng9JbWWyuTGIHep1VPynx2KKqAXMqxOhxgz5h1FdQYb45gAMyK7icOo8lShJK+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607777; c=relaxed/simple;
	bh=B2xBZBhYNdM10iCvoF09ycPRUc+Z/32cfT934Es3KLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTkqK5ii2qogh69OZrNtqX5C6Nq4YbhzCUxRyu0NPbGfzU/XRZb9n82DW+uO9X1eEmGGSlYGlznmnPgY+SDIfW1cAOabN76AV0/bj0tgTLQtbmzb0V1tyz/LkHsO86TdCpf5wlOm8LGsp4YyEQDgMlw24Pzv2wtp3UawT495ESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x5+1h81j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A8FC2BCB0;
	Tue, 12 May 2026 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607776;
	bh=B2xBZBhYNdM10iCvoF09ycPRUc+Z/32cfT934Es3KLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x5+1h81j1a8s0vDqniZj4cnJ78NDJob0jFT+pgz2p8DYa4q3Cpo64u5LHLKo6wKJ8
	 pJ2ik3F61EqcnSuKigvutu+Q2bpx8/TwLwI7v/2Q3BA72ArthYHn33TCy99/yBgCqz
	 V4/QsftBi/fAKGmA4WmsqmW9gR5uHnIhAIukHhgg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leon Yen <leon.yen@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.12 031/206] wifi: mt76: mt7921: fix a potential clc buffer length underflow
Date: Tue, 12 May 2026 19:38:03 +0200
Message-ID: <20260512173933.489356067@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4C447525FBD
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-245874-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nbd.name:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Yen <leon.yen@mediatek.com>

commit 5373f8b19e568b5c217832b9bbef165bd2b2df14 upstream.

The buf_len is used to limit the iterations for retrieving the country
power setting and may underflow under certain conditions due to changes
in the power table in CLC.

This underflow leads to an almost infinite loop or an invalid power
setting resulting in driver initialization failure.

Cc: stable@vger.kernel.org
Fixes: fa6ad88e023d ("wifi: mt76: mt7921: fix country count limitation for CLC")
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20251009020158.1923429-1-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1344,6 +1344,9 @@ int __mt7921_mcu_set_clc(struct mt792x_d
 		u16 len = le16_to_cpu(rule->len);
 		u16 offset = len + sizeof(*rule);
 
+		if (buf_len < offset)
+			break;
+
 		pos += offset;
 		buf_len -= offset;
 		if (rule->alpha2[0] != alpha2[0] ||



