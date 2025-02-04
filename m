Return-Path: <stable+bounces-112139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598DBA2703E
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 12:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EAD1652FA
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8820C038;
	Tue,  4 Feb 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMx5ck2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8592066D4;
	Tue,  4 Feb 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668681; cv=none; b=Y2G1dCa3Ip74zCqGzHhAObQPTfMmahqKZCRgiM+o3oaBVDGdWudoz3HFLeWWjaKgg4DdRBrTQsDl9aC5cvT0I1IoqNFuWHHO1imX41LfHvCUVzsKoHFjOi/cf5mKLN//1kUd+OtX6PSwrbxqoz6kesZW2f79CAWclVGo0rCbzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668681; c=relaxed/simple;
	bh=7XmKudr6uck87icOCprn9YsjKpC5QJOurnBP8lQrfBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRvQT8v2Ho2CczjY9U9Rq/PAO6sBRU29vmaV4rL9KU3UbuT6992WHIv738EbfC+wzQlIA6vu8SLsUPVBI8KdLZTax0cTP+eZytyzcx1nBdfVyukPemQoUOS4kB1GtUIgbTLtssFCGW3JcrV5oHGDyMwF9vVG9zQ5oXquAKq6w2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMx5ck2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B93C4CEE2;
	Tue,  4 Feb 2025 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668680;
	bh=7XmKudr6uck87icOCprn9YsjKpC5QJOurnBP8lQrfBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMx5ck2W0ACKRYwLdhJu9+dYZUUMWtxPa+Lc6KzbA+nRE7Sp/E/jaLUTxAsaUMoZI
	 bbNuj/TGBH1tuKbwA0bemLZMehOFe7BRJhEpPZfzZ59W4Aib65kB/R71j06yPXyYtt
	 EAc1NNEhoAdgxGbqsfu+dXm79ugwaLNeRixcZr3MaLEz5wPXaJkm9AmWpfNEaqxegc
	 p/BQ5RI5Zuem+Q7Rtlw+mVe4pIIPNi9EXJigTUgoOCHb1TLkXiUMN7JFUkYpPjCrYx
	 F4BJNjq+lB8XYz0JHM5kXqr78Ik2sBeGJpYHcz+HtYo3YaJJNx2wAsqeUpXoyfd7Te
	 ryS1gLGtcGklg==
Date: Tue, 4 Feb 2025 11:31:15 +0000
From: Will Deacon <will@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: 1534428646@qq.com, catalin.marinas@arm.com, mark.rutland@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: kprobe: fix an error in single stepping support
Message-ID: <20250204113114.GC893@willie-the-truck>
References: <tencent_9DCAEBDF4D9BCDB4687B502DB6B608E4FB0A@qq.com>
 <Z4oNbOGSluJlwpvg@e129823.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4oNbOGSluJlwpvg@e129823.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 17, 2025 at 07:57:32AM +0000, Yeoreum Yun wrote:
> > It is obvious a conflict between the code and the comment.
> > The function aarch64_insn_is_steppable is used to check if a mrs
> > instruction can be safe in single-stepping environment, in the
> > comment it says only reading DAIF bits by mrs is safe in
> > single-stepping environment, and other mrs instructions are not. So
> > aarch64_insn_is_steppable should returen "TRUE" if the mrs instruction
> > being single stepped is reading DAIF bits.
> >
> > And have verified using a kprobe kernel module which reads the DAIF bits by
> > function arch_local_irq_save with offset setting to 0x4, confirmed that
> > without this modification, it encounters
> > "kprobe_init: register_kprobe failed, returned -22" error while inserting
> > the kprobe kernel module. and with this modification, it can read the DAIF
> > bits in single-stepping environment.
> >
> > Fixes: 2dd0e8d2d2a1 ("arm64: Kprobes with single stepping support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yiren Xie <1534428646@qq.com>
> > ---
> >  arch/arm64/kernel/probes/decode-insn.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
> > index 6438bf62e753..22383eb1c22c 100644
> > --- a/arch/arm64/kernel/probes/decode-insn.c
> > +++ b/arch/arm64/kernel/probes/decode-insn.c
> > @@ -40,7 +40,7 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
> >  		 */
> >  		if (aarch64_insn_is_mrs(insn))
> >  			return aarch64_insn_extract_system_reg(insn)
> > -			     != AARCH64_INSN_SPCLREG_DAIF;
> > +			     == AARCH64_INSN_SPCLREG_DAIF;
> >
> >  		/*
> >  		 * The HINT instruction is steppable only if it is in whitelist
> > --
> > 2.34.1
> >
> 
> Thanks to correct me. yes the comments seem conflict.
> 
> However, I couldn't agree to this change.
> As I mention in last, when single-step runs, all DAIF bits set,
> so, the result of reading DAIF is different between before install kprobe and after.
> Also, I think reading some sys_reg in single-step seems ok (i.e. SYS_MIDR_EL1).
> 
> Therefore, allowing only install kprobe on DAIF reading doesn't seem
> correct.

Right, the code seems ok. I think we should just remove the comment
instead.

Will

