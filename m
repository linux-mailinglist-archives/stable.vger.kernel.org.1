Return-Path: <stable+bounces-11351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD1782F2E2
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 18:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6B1287ACA
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25DB1CA94;
	Tue, 16 Jan 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BWIExWP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8jverX9"
X-Original-To: stable@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD411CA87
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424932; cv=none; b=QSwxjTLo7T0Ho0ITr+ukPmdQNTbQaXMXIMdevPElqulo/F+0Mxa3XavfngFYr1/OLiDgoPhFgqiWLX327mEjetOglutv9aYosh4HTjCBTQ1qzHRV1t8+ZH9RHSpc5AebAgri8eQhzIM6uqZC6jI7qGn2L8XqLsSM26ciw6uVOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424932; c=relaxed/simple;
	bh=fEASXlwyRdSWTYtDQDVGyOYKVOGqjTjY6bbXk7+5EiY=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To; b=jxib1rNDsgsImP74rcTkH0FgEHpMk3coSCFvMyrYKW2quSCNhXBdm7sOvbWnefhvKL5eWXyczai1AEcgWQB/WA3fnpXi3dDqJgddydJAqJPIiLdj5tT0MvLsWJCqbIG+WRM2vBfOjRUW/91SY/oilMIMPG/bRBSrpk9IhG+j8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=BWIExWP2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C8jverX9
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id B3EC95C01AA;
	Tue, 16 Jan 2024 12:08:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 16 Jan 2024 12:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1705424929;
	 x=1705511329; bh=g7C2TbQFqWYcRCb9DSoFcXlZLOfhMp6NxZUhW98B59E=; b=
	BWIExWP2+r4GWTKe2WrQ5S9b1ssFvlEOmrKRTpOqtxoxk6dkN4q/MQR3Evmu5d12
	VmbVrbGJbKKrIwHRxt++bPJy7OvMJ9p/lQ7/zMr8Ixxc2v6mBAAnnWCzazrVIfgC
	kH8iFWoESr6yJjRLrO4UexfZlMtMsHMGHPUSI/sBdyh4Hj5aJaYq9aN+j5AacAJV
	w55tsALxxlqGyqLbrw8LVt4fXOv+61Bym3ZMpulonXN8kRY8eyhBAIU2yCm6+lRx
	TkPqXDsk7leXP7+jWFm2I4rn+1QUtW2D6xmWU68OqVBbHhMu9lyGeywhpfcU2li3
	iWdcytrHjSN2NkXZNH0MGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705424929; x=
	1705511329; bh=g7C2TbQFqWYcRCb9DSoFcXlZLOfhMp6NxZUhW98B59E=; b=C
	8jverX9aVblrSxHE4jgRAgxllO1BsXz8+ckCmDA3OpkkOjHpJ74h5bvQZZaEeUoC
	wXNvNqfbhvSo99ynIlBFlJsTm78NitHzVR6Klr82S8wzRJ/BJtE+z2wHdx2k6jnU
	Srx5B1JxUCIaQYHXAFTEFyzHxwL9b3hkAEdxLiy3S0wbor8DHR2IP5EuFRFRNtbj
	LKmUkUxMr7h69MZ2UuNNN7sBtLtDPGOHN/yocVTF7i8199+ZwTDVsPfix49GNC3T
	BNZDe0ZIut3ZAuLCwy30XMbTFv5tE153eqDItlzrTlQXFhPLwpcm4jRic/N1O9xM
	BYVLy3Pyn/vWWWEN3VzqA==
X-ME-Sender: <xms:ILimZVAFJ3Q6LTnMsRJ68De8QkoDpTmam4IuOcMVy30J6WShLY7peg>
    <xme:ILimZTg_GREo5o2exEgesNIwykNg4LFfuTJTdfoZFvsmRwR7MyPYAC10d3GJId-SH
    fRBvHoc0sWlvA>
X-ME-Received: <xmr:ILimZQmTjMWLDtD3DCHCEYgXPS0sJqDrdWUvbZQdWtAGq4KzcknOeCPgMlbnIbjhezQLDWZmjnn3ptAZ3zm1mndJ-F3U0_u-OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesth
    ekredttddtjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtgho
    mheqnecuggftrfgrthhtvghrnhepgfekffeifeeiveekleetjedvtedvtdeludfgvdfhte
    ejjeeiudeltdefffefvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:ILimZfwcJAhN0eV7pKFUVLnPDUtgVj5WbwFBD9BQoPD6h6hYcI46Ng>
    <xmx:ILimZaSD_mVhLo2kmv61FMLYVERJMKh4aUxvl4_P7gJ07n_rN1b6QQ>
    <xmx:ILimZSYBuivzlNAb2v61Yr8apaf_Xeo9Sn1dDS4GkCULAlmDqr7LTw>
    <xmx:IbimZZFeoN8gv8PhXtwr140liCHo_pD1ARVJl11CayAPLFPZH5hd-w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 12:08:48 -0500 (EST)
Date: Tue, 16 Jan 2024 18:08:47 +0100
From: Greg KH <greg@kroah.com>
To: liboti <hoshimi10mang@163.com>
Cc: ast@kernel.org, shenwenbo@zju.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH] kernel: fix insecure config of eBPF generated by Kconfig
Message-ID: <2024011638-crowbar-satirical-b02e@gregkh>
References: <20240116153414.14230-1-hoshimi10mang@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240116153414.14230-1-hoshimi10mang@163.com>

On Tue, Jan 16, 2024 at 11:34:14PM +0800, liboti wrote:
> In stable linux (4.19~5.15), if “CONFIG_BPF_SYSCALL=y” is set，
> the .config generated by Kconfig does not set
> “CONFIG_BPF_JIT_ALWAYS_ON” and “CONFIG_BPF_UNPRIV_DEFAULT_OFF”.
>  If the kernel is compiled with such .config, a normal user
>  without any capabilities at all can load eBPF programs
>  (SOCKET_FILTER type), and uses the interpreter.
> Due to the threat of side-channel attacks and inextirpable
> mistakes in the verifier, this is considered insecure.
>  We have report this issue to maintainers of architectures.
>  RISCV and s390 maintainers have confirmed and advise us to
> patch the Kconfig so that all architectures can be fixed.
> So this patch add "default y" to these config entries.
> 
> On the other hand, we found that such configs facilitate kernel
> bug exploitation. Specifically, an attacker can leverage existing
> CVEs to corrupt eBPF prog-array map, hijacking a bpf_prog pointer
> (ptrs[xx]) to point to a forged BPF program. In this way, arbitrary
> bytecode execution can be achieved, we have proved this concept with
> various CVEs(e.g. CVE-2018-18445). Such an attack enhances the
> exploitability of CVEs, and is more dangerous than side-channel
> threats.
> 
> Signed-off-by: liboti <hoshimi10mang@163.com>
> ---
>  kernel/bpf/Kconfig | 91 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 kernel/bpf/Kconfig

I don't think you tested this :(


