Return-Path: <stable+bounces-246110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF+MB4duA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:16:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E74A52734B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC41312BD3C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F453C0A1E;
	Tue, 12 May 2026 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WV4v1gm9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADF3BB108;
	Tue, 12 May 2026 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608384; cv=none; b=s7WdPRunDh3eMZtaJ4LQxACre6tmWWaCR6jfO/3j2CpOaRk2Itv8gb6imB1f3LvpR4yscXrOTlSdN2Rg2TgRJUlkFSBVq8KtR0+Dv2dzbAh5qSA+jlgI7px9B6lsGhlcV4WZj6FJlCFryPPs38pixFociUDpi8CC5SBq3iaYx9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608384; c=relaxed/simple;
	bh=ttGr5sDG008N7dUesNhPllrNwPJrdR4qGnlJ8LM2DXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rjt5mv9lYdgFvQXNsFyIuLnrUtvsMcuZH85QcUzGHo1xHHEFNu1WWsbK63ecGdAg2bE1MNOtH9EwjKgCmFHkDLAaBnaS7aZ5irANtJwzE/DLB8yJ9pMiJiAfAvEZN903xTd7hZyvkvX6Zk8jP2Hy6OIr11NuMx/4dTVm5+8pUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WV4v1gm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960C5C2BCB0;
	Tue, 12 May 2026 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608383;
	bh=ttGr5sDG008N7dUesNhPllrNwPJrdR4qGnlJ8LM2DXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WV4v1gm9JI9ERA2PJb8j7OjD7PcM6lC376bhhsRGmXxv+t2dVmCByTWYp32kXYVdq
	 oa/9IdYgMoM7bZ4Le5gLQwxyDu4y0ThNzaa3gUXPV42cHp/7Dus5bQ+wPCh+CWFXoX
	 oasgIQaT0wgvoQs00K24QmAcaSsnqLAWgL7AKmJA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ruide Cao <caoruide123@gmail.com>,
	Yilin Zhu <zylzyl2333@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 6.18 058/270] ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()
Date: Tue, 12 May 2026 19:37:39 +0200
Message-ID: <20260512173939.673911612@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 8E74A52734B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246110-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,secunet.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,lzu.edu.cn:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yilin Zhu <zylzyl2333@gmail.com>

commit bc0fcb9823cd0894934cf968b525c575833d7078 upstream.

xfrm6_rcv_encap() performs an IPv6 route lookup when the skb does not
already have a dst attached. ip6_route_input_lookup() returns a
referenced dst entry even when the lookup resolves to an error route.

If dst->error is set, xfrm6_rcv_encap() drops the skb without attaching
the dst to the skb and without releasing the reference returned by the
lookup. Repeated packets hitting this path therefore leak dst entries.

Release the dst before jumping to the drop path.

Fixes: 0146dca70b87 ("xfrm: add support for UDPv6 encapsulation of ESP")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/xfrm6_protocol.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv6/xfrm6_protocol.c
+++ b/net/ipv6/xfrm6_protocol.c
@@ -88,8 +88,10 @@ int xfrm6_rcv_encap(struct sk_buff *skb,
 
 		dst = ip6_route_input_lookup(dev_net(skb->dev), skb->dev, &fl6,
 					     skb, flags);
-		if (dst->error)
+		if (dst->error) {
+			dst_release(dst);
 			goto drop;
+		}
 		skb_dst_set(skb, dst);
 	}
 



