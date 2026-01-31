Return-Path: <stable+bounces-212925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IzyAQtPfWm+RQIAu9opvQ
	(envelope-from <stable+bounces-212925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 01:38:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F5DBFA7E
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 01:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D90301D688
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 00:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1302FFDEA;
	Sat, 31 Jan 2026 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYnxHnU/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A519A288;
	Sat, 31 Jan 2026 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769819907; cv=none; b=Fajw2WdPJsywEDFrC9rzpRAiRqkOVLA9borf1F49saAzT+aJ6JumOaT6mgc0Dfgqt/Rac5yQhyYBF4zdR1d25UbNY02FbVQApN8HnjyjL8qzR7fJRb0CrHbWfuBxqpjyI+aa1xs8ouLP90I1poYRR27fgnr9bMPa2AzFyI0HISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769819907; c=relaxed/simple;
	bh=Jdd3buLMaqZBkACwxbSaZ9XyMhBAqA5jAjxcO9QTh9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+ALXqIiwOIVfSJUqiWPTxf6oQQPe9GO1o8sFxPw4ajfkF36wzypX+d1VtGNuBMBg7AdNz6Ru39tYa5ncx+aeD5CSO9U8SJm4U2Z8WB7Pt+ee2T7Wc4MFrg6J7dymHRYfdgKF5tN60aeS8cGfnHEQOAC5UqzBBNBE40KHBxizpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYnxHnU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F75C4CEF7;
	Sat, 31 Jan 2026 00:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769819907;
	bh=Jdd3buLMaqZBkACwxbSaZ9XyMhBAqA5jAjxcO9QTh9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bYnxHnU/XJ9Lk3D3akKRWErAxebiOZiN+kzUeQWoviWRVSAWgyfw3bHNYtPh1qdXA
	 hGEpFGoyweQuOeWSBNm7f2vRN6k3b2i3q0kheVi6pnSmB3WWevIouZYMhOx1krHN1N
	 yAjWxNv05ePs/d12c96gt4DeQboX9AN6QyO/9cqNUP9AyPSP8pHlN5ubIaly2KxW/P
	 qiNQyFR64beaeD+/ja7YCcglAU63W+qnscbckUh9A0+TeYf2ZL/g5Zzwvmymk8dG7q
	 OVeRmngY8jPaXfQ1cj5PQLWceUHwSE+Kay6q3yCiuCGm05ceeVDSvJrDMSsCj34STd
	 w+yl4p/EOAeyg==
Date: Fri, 30 Jan 2026 16:38:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Ankit Garg <nktgrg@google.com>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org,
 Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Catherine Sullivan
 <csully@google.com>, Luigi Rizzo <lrizzo@google.com>, Jon Olson
 <jonolson@google.com>, Sagi Shahar <sagis@google.com>, Bailey Forrest
 <bcf@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
Message-ID: <20260130163825.3b63222a@kernel.org>
In-Reply-To: <CANn89iJ=Gfjves4qN6hu_VRPSedVRosJsvEQC_irFnEJU_eMLg@mail.gmail.com>
References: <20260105232504.3791806-1-joshwash@google.com>
	<20260106182244.7188a8f6@kernel.org>
	<CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com>
	<CANn89iK_=W8JT6WGb17ARnqqSgKkt5=GUaTMB6CbPfYuPNS7vA@mail.gmail.com>
	<CAJcM6BH11e4Cs3=7B3Uu-JxPeq4BAnQ3VDLfCAN_JcfnPLtOaw@mail.gmail.com>
	<CANn89iJ=Gfjves4qN6hu_VRPSedVRosJsvEQC_irFnEJU_eMLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-212925-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58F5DBFA7E
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 21:56:07 +0100 Eric Dumazet wrote:
> Jakub, the issue is that before 4.20, calling synchronize_rcu()
> instead of synchronize_rcu_bh()
> was probably a bug. I suspect we had more issues like that.
> 
>  __dev_queue_xmit takes a rcu_read_lock_bh(), while the code (that you
> added in 2018 [1])
> to update the queue netif_set_real_num_tx_queues does synchronize_net()
> (aka synchronize_rcu()) and in earlier times, it would mean that this
> would maybe return too soon (say on preemptible kernels)
> 
> [...]
> 
> So perhaps a fix for pre 4.20 kernel would be: (I kept the
> synchronize_net() to be really cautious and because I really do not
> want to test)

Sounds entirely plausible, FWIW. Ankit, this would mean that you have
to convince RHEL / Rocky to take Eric's patch. Oldest kernel we can
patch upstream is 5.10, AFAIK.

