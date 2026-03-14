Return-Path: <stable+bounces-225444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLbhNqi5tWmc4AAAu9opvQ
	(envelope-from <stable+bounces-225444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 20:40:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7909628EA42
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 20:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 975CB300B9C4
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA444376484;
	Sat, 14 Mar 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqP07XyF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF281A2545;
	Sat, 14 Mar 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773517219; cv=none; b=fJQQ8+lUL3pb8Aty+8j7VSxwWzkVNpPWP9RxXyTi4Z22g3pDxd1veSLciAISOw95CD5b4vpUadoYoan/Z1rmYdA8n7F4OYO5MLJaStttfm27E/SvMhbyA77h5Ym3Il/CzsO1iB24cYq0I6onzEW/z87H9XtVVJtE9nDF8VyxcVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773517219; c=relaxed/simple;
	bh=c757BH786h+8dHhr8zlcXZnlfq1ws0dMp0fDoFMBHOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcwUy1vRm450q/t635wRLDEeREaLlPwNxb46DpWr5rsF4kFbtsMzDMqPvv/KGWZZTqo72UI1/9Z6oZ43OWJyQazZLmkzzWOslry/ES1xEzjTK8vH16D2XvXdJq5KRoJqXTtZ8zf4t6EmcsXFmKHCXYnyRHL8PxjVe+WagoTa2KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqP07XyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6961CC116C6;
	Sat, 14 Mar 2026 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773517218;
	bh=c757BH786h+8dHhr8zlcXZnlfq1ws0dMp0fDoFMBHOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FqP07XyF2qwq0uUU046PFs953LfRjh32Id64KoJdKvy62UrblZ1Gc4XZRu7vyMdal
	 qZrY+Gt1h9ge9SSCn5Y4vnp5DoQ9ePt27C19W4SHeH9owtzpGrRrvm4U34amJ5ob+Y
	 gTjfjWM8HZrjpsDoXCockTYI8TiReDgQWfO8c+zHQEddcpo30UlYm0H2+wiXNI2huO
	 H84WZjUzvVKyVw/zqE8AW/JLonaNIjEu5CEaEClJnckG347RZtBquLpSTJDiFwkyqM
	 a6rtRa6Gdfn6fYoX/CKEC6qK6o/7pigAwzIDTRkqp5+wTvCauQViUhlmBhatpFld+L
	 0lskhHTjMi0zg==
Date: Sat, 14 Mar 2026 12:40:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: xietangxin <xietangxin@yeah.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
Message-ID: <20260314124017.59206dac@kernel.org>
In-Reply-To: <20260312025406.15641-1-xietangxin@yeah.net>
References: <20260312025406.15641-1-xietangxin@yeah.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225444-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[yeah.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yeah.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7909628EA42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 10:54:06 +0800 xietangxin wrote:
> Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside the network namespace")
> Cc: stable@vger.kernel.org
> Signed-off-by: xietangxin <xietangxin@yeah.net>

The Fixes tag should be:

Fixes: 0287587884b1 ("net: better IFF_XMIT_DST_RELEASE support") 

please fix and repost
-- 
pw-bot: cr

