Return-Path: <stable+bounces-181505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B51A8B960D0
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BFD2A7211
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E3327A1E;
	Tue, 23 Sep 2025 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Xa9uIA86"
X-Original-To: stable@vger.kernel.org
Received: from sonic314-19.consmr.mail.sg3.yahoo.com (sonic314-19.consmr.mail.sg3.yahoo.com [106.10.240.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F381126C1E
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.240.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635054; cv=none; b=T5GS1G2dSpm2DTVTl9cOj5YLjWvFPxWw7Ug4GMJsrVMh2DyQQtlQSDPU1XtdPKiG3vt1VwuQDwNYtRM/PVqXVsw4yEN4yqvibXVizfcCyAB6LM/1PPGGXXo5+QKtBw9VDMKSDB1Bv500uZ5A5qVUrwGZJkSROsguqCnwQ5DEWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635054; c=relaxed/simple;
	bh=yd1cpLLfQcHwI3mATOIzXz5vu6mrl+DoW1ozUOgg5rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+QaYpkS0tvxnV/xgR0SXFsbzetATuR1svft5BJBvoBYjyxcwIQO5lh9Hl//SwCE6FuTir/+v+6lL8e0sfmaeRzQ1OOKZZhQkluospC4MTkp0xC1LzNHWM3hOaEqlhXdb4cpYZ8Aet2Anfc0+4PtcbFIXUC0MaGf1e9iZzb7a6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Xa9uIA86; arc=none smtp.client-ip=106.10.240.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758635050; bh=yd1cpLLfQcHwI3mATOIzXz5vu6mrl+DoW1ozUOgg5rQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Xa9uIA86ivcUPoMb4r5X8lw585uGRn8mrJ8c+KEv3uHNfkkRHTT13URnbO2TKsgzZ2eZ1IxBWyhFOJzmHBcyeVFeRmxxbKF4D8u/qiA/PNjB/zY6qLw01OnfJaQlCQEUJBYVQH9HH7uxB+F+2tNNjscTc3Qb887qutUEAMthS+xXyISkKStT+oqpaeM3415eIP6pC4cuQpVSpEpQWJ6TTdHPjeDqjJH8QxG/ku0q9AvZbs6gPxpTwj+CFowlj2hKECIOpn+N2q8Mc/fuOlL1AfUfzSXw0Pf2IVzxawggCLANc+Wl4F2zy+5cwmvwzBcTYsbePGZcaQua6h3YgntKmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758635050; bh=xlRT6OjuSbXTjyPG2YPnRw4yx5Kytvc/P0/XfEzalkM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=q/6hDucFzMOsxwtSXxzJvFsRW1vhHK4ACV7E7i7Q1mnnjYnOe0VrUgFa1Nv2LfV6I9rhVG3Mhta9ZmYyEINe51+9dnWNGK5FYG0gagk7uVAKWKbFaClCEquoDyqlNikA1Z20PKsH1PuqPmBSBOjOfEi7NwYr3QG1kQaAfLP94wQDGzfn0rAitotiw8qUy5AD+c2Us++UsB28GAcd6Bvvpdr7vdySu+8XnBDxPsZVg9MiUsLi+4vNsJ+TOm3jpq280D4DFeUItTl3E4yVh3iQPcnw3cJEZ5/bI8ktFE162+Hcgg4wHNCr6dAZFTFQkzZfukBl6w5ThjW4DdMi11u0Pg==
X-YMail-OSG: 5_2A6u8VM1lg9iSqldO9T0blGH2a37pYfr1RoFXtfy540X_d0xzb.ae4LTLmYuL
 sNb8RgvVa4GWstzueDFGPIiEktycQk9QUiSAdViBX2xlsqjnrfvAhQHenek7y6DLROHx09R5mLKS
 pZyPU7hyrlE1xW7071QZfzKYgyYEcaHkoSGBxS7oQ.D9lcLSZfMy3YPNzcbA7RxgNxXKYHv2hdmB
 oA1Paun.adVuuF_ipiq.JO7tO8O0FABrokE29stZDCe3E9j1Xt2vPhWj5ScTmBMAyWZiUh.RXNhD
 .jDwl7wOEe3qjvihVTpmNkEkBhESI4ePhsd_WqVdHZ14DPHCNQU0HorkA94gl29MPdi48NLoy4vr
 jjsfqviFGZky84Rq919Hs_zjb7t7pWEqYaeoy.nv4lUZCXd9mb2evWbU6yon9vFdXkjfJJsvCHGt
 se_5WGsnMVgDsb7Sg4EbERB7n3MWHtc0WTMfzmpv8vyP6mHfyIj0muLnhfrU83jqCwCxkJqTRjby
 1x.urFs0RBZUvNVXA8mybBkOeTIEnluCbNrCqZuIVcsDJwkyZ1gM7I67dH6ReLtHyloHQVM_1CTN
 9u.U_5r4I3G9c9qed9VRhbOV050AWrUVMXWExHgnVo9AtnOeGdJ0WkzqI0c4FKcDhacmrd5XgUWt
 .cs1zf1k6Ki5x1n.FRXkSu1AeMpfxOFNWE.PaCCyjx6wi6oByowCfY3cZ8eW4mXZKpb8jEywd.gu
 734N04T8c_KL2GpSlEVUozaFUdSyyB0fUMRNrfEakw5ABmRmJ2NHdFeVNv1QXXUn0.M8GEWZqlub
 0SlOLQkpJgXTyMXX13OnfmmDQ7mgFUr1detYZILhLQEuIztnDXbDXceiHCwIT8n_7UwQeGDUJRos
 Ase0DulDNz.8Of5kTCn2V58GsLtg_x8E53jza2LerUmssRrNh5wS2a9A9VOYn_2JrUm9qOwkCW1o
 gdRO4E2zG5ukJJr7O9dMohSsbLd1fHrEuVgLojsVa4N4CThGQClA7e0n6BwWvAAVT1WHZz4mgOZK
 C.b7iupdJEh48t6NV3Wj1WFKsGDKT.vpY9hWvaiosBpmAjFtKpXzmpB6i6DEEkVAWuhNXLbvDFQ0
 ZvISFno48n.B_VMBgVVot2llBrarEg7OunXSagq3oyBKS3c1T4XyoKApV4oEpnr6rahosaOTfbil
 ZN.qxOCTUiNhe831813.YSl1HKppB0MX7LyJOjqx_Rfr4I9s1KhWokVbMabelp7xtX2eXPWowdNR
 oqQVwj5vZ3Ien1qO01dxMzTdGYw7NKMEKbluBNVncy8t4hqvE7igyCQdgXdHqjrBfzCOtqn9Rwk7
 7YXwOm8d5NkeML33vHfp_SWJ9ri3uHkie9vgupVtDXshzbImdS8vcAZYSFzq0Ddp6HSWoaKznFju
 TFoLLeM4sIEt7XxNj3KaYpyOLE6QCl2eCPSgXGYGm3DQg15as3ZCH4BieUOG2wxlGJSEvcZYINR1
 qGItpnwH1v6K9QecadLrRGs4ydZlGryZvd_doDzCjMuauB6.BpHASFvS8yWs5NVrfQZL_bDZhsu0
 pPXL4tDVkVhtjwLRFgCeIkXOFFgYeQyGg3O8Yws.p7NmZbrSzS2t9DTwF.F7X8jSS1S2.RAnoDpk
 FLNoAykUHKQmTzRPPF6VOFo9vw0QqHkyauk70rLEBWptMhmolGTSv4pUvop9PjsnUs4xFwK_wmXC
 2pgOxxzcoIy4v4Ahka0T16R96kxWXnG1Kr1cCy8PPlFaxU6FqrEsmobCHHzvSxPSvf53Q1xbSa8e
 TaBGPAK_f9mGddj_jvma9LZMRnkGqell1yYRCvnYt1Cn2D8UrJKMmU0ugLC_xhYWlOSRW6uHZsZG
 OA0cGpn7hFcExO5SgVChuHI_hXXGqcl.AikQuFe1XltcqKm2Ez6ZVePouW1dP6_tZq6Anbt9Zo7O
 9c_htrJqjvXNOWjzZTme1wWeS8xTboHPmdl4_BnLOtxnRrnWaWPsdDC_dPEN8t8NYazp5YqW3K5P
 zZLo7.0N.1EK.rIpthjOud3iXR3eB2sSQ1.T54k4zzKJe9mr8P1CX39IoT0YaYCkR83QO71_J_an
 Q2J4UYs6RPghFiM3GHOxiizD9P._O4NqKoKtmprSwijdlltHe4dhvZaWKKPKgai_s94RVPdzg4qO
 d3kFqgAr.ohXVuDUhfpl1fNUs.dr4bC.2EIbVC73O2sxnKtc.lyCI1RFo8UEJPnx6hPD2NuXz5aO
 ualRHkCZpIRVpuuEC3BbWmAM2ea1agZEb36tHsI4P2yuFwc5jFoZnd81UF8clrx7FUOER7rD1PX4
 meoJTiYo0oF0-
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 52be80ae-1744-43ee-96f7-11a0fc5dda32
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.sg3.yahoo.com with HTTP; Tue, 23 Sep 2025 13:44:10 +0000
Received: by hermes--production-ne1-6b9c565dcd-npnnn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ef9c3dcafa6eacd1c26e38b32d340bfb;
          Tue, 23 Sep 2025 13:13:40 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: tglx@linutronix.de
Cc: boqun.feng@gmail.com,
	clingutla@codeaurora.org,
	elavila@google.com,
	gregkh@linuxfoundation.org,
	jstultz@google.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	sumanth.gavini@yahoo.com
Subject: Re: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
Date: Tue, 23 Sep 2025 08:13:33 -0500
Message-ID: <20250923131334.66580-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87ldnavsse.ffs@tglx>
References: <87ldnavsse.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas, John,

Thanks for the feedback. Just to clarify — my intention here was only to backport the already accepted upstream changes into this branch. I do not plan to introduce any additional modifications or syzbot-only patches.

Thank you for your time and consideration.

Regards,
Sumanth Gavini

