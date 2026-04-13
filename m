Return-Path: <stable+bounces-236344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLL3LjoY3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:22:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB553EEBB3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8BC31D4C1E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002B277026;
	Mon, 13 Apr 2026 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xKtGpAp2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79142737E0;
	Mon, 13 Apr 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096663; cv=none; b=MJCAx9dW35HJ6O2MTzYYyqC7Su92+dkEIc04idP5oIbu2eZwqGv5ifNhd6l2HkkMN3ho70CamVVxq9AFuDbtW596E/9hZh6tUFIZfSxUIW2114irfgjfLZ5HIc0SIPkHnboqaeg2pnGAafy1+9ftQcXsNFg8j/HwCtsScQjEdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096663; c=relaxed/simple;
	bh=V7N5sZBNy/zZx3+xwGPvpX+TAzzjWxsmMVoAo4L3mQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQp6isNNbUallUsbHDsucSYXUSWwqTcghiuFFjt/iBBfzI3bOSG9R7xHpajGEMvSEuI/dvBRdUcolEYylvfDIj9B/SulF5hSGXKlU+Cmbce3nxkR9fF29GhbeALcsBA0qrRvGJeRbYNFzpYXMoLPadbcolF5rZlzCDtwmLpx7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xKtGpAp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD4AC2BCAF;
	Mon, 13 Apr 2026 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096663;
	bh=V7N5sZBNy/zZx3+xwGPvpX+TAzzjWxsmMVoAo4L3mQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xKtGpAp2bsNBAC0UAMKvJIAkfA1L/bzPN7njRfyZuPeW9BPizdeCD7p/mUHleP8ZW
	 YDo3+232/4+BOKm4Wy7O3Di6OSteE4gbSAzLBbBrDPS9pCimZBSAAEOSDhV58l1enK
	 na8iz0o0xwhAePouN8/PfLwW5UN6XEx+oRnarZPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 6.12 04/70] xfrm_user: fix info leak in build_report()
Date: Mon, 13 Apr 2026 17:59:59 +0200
Message-ID: <20260413155728.347857467@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236344-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,apana.org.au:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,secunet.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CB553EEBB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit d10119968d0e1f2b669604baf2a8b5fdb72fa6b4 upstream.

struct xfrm_user_report is a __u8 proto field followed by a struct
xfrm_selector which means there is three "empty" bytes of padding, but
the padding is never zeroed before copying to userspace.  Fix that up by
zeroing the structure before setting individual member variables.

Cc: stable <stable@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_user.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -4006,6 +4006,7 @@ static int build_report(struct sk_buff *
 		return -EMSGSIZE;
 
 	ur = nlmsg_data(nlh);
+	memset(ur, 0, sizeof(*ur));
 	ur->proto = proto;
 	memcpy(&ur->sel, sel, sizeof(ur->sel));
 



