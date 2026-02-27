Return-Path: <stable+bounces-220002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOyyCqbwoWnYxQQAu9opvQ
	(envelope-from <stable+bounces-220002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:29:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1381BCCBA
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 666F630DD542
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A6A3D5222;
	Fri, 27 Feb 2026 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDe5cDS3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C337419A;
	Fri, 27 Feb 2026 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220275; cv=none; b=PwsNt6ZomCYY+UpdKwOJPH1Yjkfu1XdmCSsFXL8Hg+8aol3SaHsBdY6EcFXNHJV+tfF0BsgUBeceHVM9d+v7l90Vqgi8imXjvKbwysn3oguC+PtwcUZ5eHZi9wwO5W7QIHgliwvQn1TTWftBS9UuMR1DYR6fbdixSdRmrhVgi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220275; c=relaxed/simple;
	bh=sBt5EGCwYG0tFtqY3cHg7yeNgdzjAr/+YdXLcrh/CiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h++wn4qrfroqzI5oZBBO6p9mJdMrjn/8UPr2kXm5Iy45oWRkUQG0+WiB/w9R4V+gLhaqK1LgCnuLdf+mXsR8s5zyxvV5TyaJkR0lYf5AmxP2CX9NrStoNaSuDfo0IGv+kpPpKuK/2QBJA0jTYtwmYHaTjl6nnWnR1EwCNmyTcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDe5cDS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5F1C116C6;
	Fri, 27 Feb 2026 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772220275;
	bh=sBt5EGCwYG0tFtqY3cHg7yeNgdzjAr/+YdXLcrh/CiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDe5cDS3onxQ1jGOzMhZSFAcHjqvQVuljoz77NZQK/r8vH7pKXb3NsNmPgwohoVxt
	 RrOZ06hmRVQ5msmJ8Ao1aogDHoWajSadJagwcp0TcwM/EWNVpDM+7W10pQXJ+bxIPL
	 fOufEG8N5euvLhyvDx5uie1bBXTce43UXsFJkLPi/RqANAIPu5MlskamAGK/9mIL7w
	 Ku+2c/cRV/SNj9OB7tqn7XU93QLuJ/INnyQTfekMFgLPZbN8IqiTpAZwiyP54DJPDu
	 l76EQnIb4ssKTjIWCkJZZy4UM61QIvxYAftYS8icvf792Za/JzEC7R4vXcv4IkhlhL
	 YSbWlJbRmbI3Q==
Date: Fri, 27 Feb 2026 09:24:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: workqueue: restrict delayed work to global
 wqs
Message-ID: <aaHvcvbmkl7oSFOR@slm.duckdns.org>
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
 <20260227-create-workqueue-v3-1-87de133f7849@google.com>
 <aaHPs-nULPEt_wJB@slm.duckdns.org>
 <aaHp_pGBxA4pNiXJ@google.com>
 <aaHrxzWIFFUjzWhu@slm.duckdns.org>
 <aaHuXEO64ONKMW4O@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaHuXEO64ONKMW4O@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220002-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: AF1381BCCBA
X-Rspamd-Action: no action

Hello,

On Fri, Feb 27, 2026 at 07:19:56PM +0000, Alice Ryhl wrote:
> I guess the question is, what does destroy_workqueue() do?
> 
> - Does it wait for the timers to finish?
> - Does it immediately run the delayed works?
> - Does it exit without waiting for timers?
> 
> It sounds like the refcount approach is the last solution, where
> destroy_workqueue() just exits without waiting for timers, but then
> keeping the workqueue alive until the timers elapse.
> 
> The main concern I can see is that this means that delayed work can run
> after destroy_workqueue() is called. That may be a problem if
> destroy_workqueue() is used to guard module unload (or device unbind).

delayed_work is just pointing to the wq pointer. On destroy_workqueue(), we
can shut it down and free all the supporting stuff while leaving zombie wq
struct which noops execution and let the whole thing go away when refs reach
zero?

Thanks.

-- 
tejun

