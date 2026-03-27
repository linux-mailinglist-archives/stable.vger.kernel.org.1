Return-Path: <stable+bounces-230578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP08JRv8xWmOEwUAu9opvQ
	(envelope-from <stable+bounces-230578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 04:40:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D3933EDB1
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 04:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 495C9305934C
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2D36A036;
	Fri, 27 Mar 2026 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gWcrzCCv"
X-Original-To: stable@vger.kernel.org
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300136E468
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 03:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582794; cv=none; b=DuW5TvXo8hW9UuqdXnw9x53ZLMGfGxDQQj9Tkz9n72/DpIFDpggcoKKbweLhKdGVCyFBFcE3ip3nhDu7wVcWRk1SJXt9JNAObT+rL4Gd7h5t2lneLd1b0E+rOB5XUlTqc594omXXomm0EcWokPES+vVSTPEHysDzF1Oma3ysKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582794; c=relaxed/simple;
	bh=CD03pVkqgdiijeQEABfG2OeBB08QAQFprrGnnC4rnGY=;
	h=From:In-Reply-To:To:Mime-Version:References:Cc:Subject:
	 Content-Type:Date:Message-Id; b=IIsZybNvAadLjXi0W0jjHuaaXWWnA9NC9zfSul6KCgINlseCpET95h7467xzDzeI0YVb3JYreM/ZUTCezWxMzosH4dDzgOS9xYNi8pXWAkIgs88Yv3aacvkhbsx9yRBl6gYlimSwrtm+p1DV8B4ijsq9A4hQneThEnFjVbul2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gWcrzCCv; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1774582776; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=0ED32FdF0T/NCMsa7VWUG/TMWqAgSzH8xwcl1INvd08=;
 b=gWcrzCCvOG7521iLpfEn9Tm+0uqIP41FKDc3uMmy2t3KDFmzKJumGu4HHNSm3kkhd5GizI
 K61sZhFceKZEv5bDawikgSoYKfzn8fxkI4YvVXxSsXkQBCWp1qXrxNjKlhZxWUfwVotZdp
 DkqavTWNnL5Heuxtlm4g3VSzzRadYXXvzwHb/Ltu7jr7jXGOsJX2L5u2cVEhHqdcM5H2Cz
 j8D7InucpGVqEEO8ClG0D5vSZgp+LZnY/B4jAzk/8DTnwHkDQegedwgkaULwq5sQTSslMI
 Al93dubtY/EPGM0frNQeUPPY5ldfm0f0u8J3GJEycX4jjE2Yx0/4s0Pdj/rt6w==
From: "Rui Qi" <qirui.001@bytedance.com>
In-Reply-To: <20260325121109.89705-1-qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+269c5fbf6+15f4b3+vger.kernel.org+qirui.001@bytedance.com>
To: <minyard@acm.org>, <corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325121109.89705-1-qirui.001@bytedance.com>
Cc: <linux-kernel@vger.kernel.org>, 
	<openipmi-developer@lists.sourceforge.net>, <stable@vger.kernel.org>
Subject: Re: [PATCH] ipmi: Fix rcu_read_unlock to srcu_read_unlock in handle_read_event_rsp
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 11:39:23 +0800
Message-Id: <6304d593-23c5-4ea3-9ae8-b54911eedf96@bytedance.com>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230578-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qirui.001@bytedance.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:dkim,bytedance.com:email,bytedance.com:mid]
X-Rspamd-Queue-Id: 25D3933EDB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 8:11 PM, Rui Qi wrote:
> Fix a bug where rcu_read_unlock() was used instead of srcu_read_unlock()
> in handle_read_event_rsp() when ipmi_alloc_recv_msg() fails.
> 
> This mismatch can lead to SRCU read-side critical section imbalance.
> 
> Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
> Cc: stable@vger.kernel.org # 6.12
> 
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 71c6ec8a87927..d2bbf8ffd9d76 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -4388,7 +4388,7 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
>  
>  		recv_msg = ipmi_alloc_recv_msg(user);
>  		if (IS_ERR(recv_msg)) {
> -			rcu_read_unlock();
> +			srcu_read_unlock(&intf->users_srcu, index);
>  			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
>  						 link) {
>  				list_del(&recv_msg->link);

This patch applies to the LTS v6.12 branch, base commit
48591125594050ab91c9156bccb3ddd9a869d9f1

