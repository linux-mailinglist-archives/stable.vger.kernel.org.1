Return-Path: <stable+bounces-98225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D209E32BA
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E79281420
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7324174BE1;
	Wed,  4 Dec 2024 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="y6qtfIEb"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC42500D6;
	Wed,  4 Dec 2024 04:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287545; cv=none; b=QpqRDGykzDj/fxXJZSplr+peRT8wdrEyzuF6TQSbzI3TyCdZPAfRGhTQCWKXwS6eln/dNMdqxhalSgKD+HmJeRjuYIi2IeAiWOE26nL6GDoU+rXyoLCvHFkqRuhxhocV/H4ZBTQGPOuxm7O3POUTQOvCz9DfzA19xJa2X/uj9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287545; c=relaxed/simple;
	bh=XwLbTzFiAE5SI0qI0DgMmjn+R8D2LmCtWfFtwHhH2bE=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=NdDBjV6PEusjUfG3CuZUIyw0falCsjPtFqVJMeXTIWTRaUPcY/tbgXVLzD65tNyiSllKSHIlVdbGKb2eE7plmkxGsH4Gq8n2sNaSymR9PBmktz2mBweJkKPNAxrTlg30qN/FS8TIrwN42Kdhq4T9KvV3fNSQzuq5HnIXvWHtJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=y6qtfIEb; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733287534; bh=U239pY3v8KPxGhdBjoNQzmm5zyQwq19JmuP2wUPnm2U=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=y6qtfIEb2b7kzbfXCUkjnY9q2vWdg/9RnEQJvUrzlhjDiIvwksbjAv46uFKxGy8Yh
	 iAjNhUrvg8aq6Rrbyw4RkXGz7E4xWfEef6v7BTwfIakHG6aej7rHPmzV0uTzFRVaij
	 YRmKm+jUquAZF65P95Eb2U5pc85tY86tHSZywa4A=
Received: from smtpclient.apple ([2408:8207:18a1:fd2f:c2c:ade3:99d6:a00])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id B5DAC603; Wed, 04 Dec 2024 12:45:29 +0800
X-QQ-mid: xmsmtpt1733287529t5la5omw5
Message-ID: <tencent_249C769EA3122E4F0C45084863109F83A006@qq.com>
X-QQ-XMAILINFO: OOEWBQXMvCdj1LJL0D5mNDaEjpPBd3fUDyoL0Ui/QFCqvZ9eHyNaX4U3EHPa6F
	 vN7iMrMS5O11M+04+iJothjzoD2gry39TGs2ngCTzlYtGwJIT57p8MLpP3QVpcl3CTrGea7S2pez
	 EQW2oZbt1WEbbtW0YK4F99bKThj+7DGpnhtw+7Lw79vAbPZMA5C6kf1xENUYt9Sp0kCfPieRBQ04
	 HjuAijD+ruvGQM4OGWmpgneKP0e5ryzsGh71kg/4a40AhAjN2Sr1Rx1sqylpGu8klfK/GkxRpjGs
	 GC5Cu0vSf7KR8Xgg6fb9HW9ERf2sdxLqBtv0ZkFQyYLVbF6WtIzV5MyLOUNtiHslq2hQHkzvaUuB
	 dwB7M7Ao00pZJARYVauy4XVe8IC07GKZIYxJE9suc6gsaIZ6NwG6fIkYtKdhHStmBeyLpfCqmoQk
	 qMKxf+qPWtrAW4rJE7rQ4lhpY2ERRHdEFndDRFRfFXyI7IdFUva+z9EDNyHx2QkSgnZBwelB/3MD
	 gSYSlr2q3hqErGtXul1F2R60llRkiASTMofSIhnKP1EQ3vaoRJOujvYcgbEZVuIpJel+cwaCVp49
	 fINBdi09Y+SM8wnoCHwGcuBj248Jzjhn3sxmNwRD1nrpHFfTExSXQTHg8pyIYpSnzn2tR6IT8Bsv
	 u2PrNtjghXVcJ4FGl8VnZYG7LwXKU9/H30ahCrYfDl7Pgyv45RZvGBHC7Q3/VuwTfAu1BsoAYGIC
	 xxyYucP8c0FTDpneCRkgZ93eqaQQ2A36sqtr4uZ8OyHi8jhv2Qv58iJq7ZD2dybfaLSUecbQ6M1R
	 Hee9N99T/hRWp/J9YZrEBDvVCkilr6Hf8czjE/0jPUap782mJCcug2FKj7hCoO5Xj4AR60bACuuY
	 NbgpHFXUwZyJ+DLgeqq4sVTYEi2n70RVmkcJccPGI8FGsfO6FcOyhx1PmoZW38Nm19MGtV9Z+iwc
	 LiaTsifmHp1QtraSHDMA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] riscv: Fix vector state restore in rt_sigreturn()
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240403072638.567446-1-bjorn@kernel.org>
Date: Wed, 4 Dec 2024 12:45:19 +0800
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Vincent Chen <vincent.chen@sifive.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Greentime Hu <greentime.hu@sifive.com>,
 Haorong Lu <ancientmodern4@gmail.com>,
 Jerry Shih <jerry.shih@sifive.com>,
 Nick Knight <nick.knight@sifive.com>,
 linux-kernel@vger.kernel.org,
 Vineet Gupta <vineetg@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Vineet Gupta <vgupta@kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <1D423665-AF23-480D-8B68-414A54222F2B@cyyself.name>
References: <20240403072638.567446-1-bjorn@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Andy Chiu <andy.chiu@sifive.com>,
 linux-riscv@lists.infradead.org
X-Mailer: Apple Mail (2.3826.200.121)

I think this patch should also be backported to the v6.6 LTS tree.
Since it should recolonize as Fixes: 8ee0b41898 ("riscv: signal:
Add sigcontext save/restore for vector") and that commit first
appears since v6.5-rc1 and this patch land to master branch since
v6.9-rc3

Thanks,
Yangyu Chen

On 4/3/24 15:26, Bj=C3=B6rn T=C3=B6pel wrote:
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> The RISC-V Vector specification states in "Appendix D: Calling
> Convention for Vector State" [1] that "Executing a system call causes
> all caller-saved vector registers (v0-v31, vl, vtype) and vstart to
> become unspecified.". In the RISC-V kernel this is called "discarding
> the vstate".
> Returning from a signal handler via the rt_sigreturn() syscall, vector
> discard is also performed. However, this is not an issue since the
> vector state should be restored from the sigcontext, and therefore not
> care about the vector discard.
> The "live state" is the actual vector register in the running context,
> and the "vstate" is the vector state of the task. A dirty live state,
> means that the vstate and live state are not in synch.
> When vectorized user_from_copy() was introduced, an bug sneaked in at
> the restoration code, related to the discard of the live state.
> An example when this go wrong:
>   1. A userland application is executing vector code
>   2. The application receives a signal, and the signal handler is
>      entered.
>   3. The application returns from the signal handler, using the
>      rt_sigreturn() syscall.
>   4. The live vector state is discarded upon entering the
>      rt_sigreturn(), and the live state is marked as "dirty", =
indicating
>      that the live state need to be synchronized with the current
>      vstate.
>   5. rt_sigreturn() restores the vstate, except the Vector registers,
>      from the sigcontext
>   6. rt_sigreturn() restores the Vector registers, from the =
sigcontext,
>      and now the vectorized user_from_copy() is used. The dirty live
>      state from the discard is saved to the vstate, making the vstate
>      corrupt.
>   7. rt_sigreturn() returns to the application, which crashes due to
>      corrupted vstate.
> Note that the vectorized user_from_copy() is invoked depending on the
> value of CONFIG_RISCV_ISA_V_UCOPY_THRESHOLD. Default is 768, which
> means that vlen has to be larger than 128b for this bug to trigger.
> The fix is simply to mark the live state as non-dirty/clean prior
> performing the vstate restore.
> Link: =
https://github.com/riscv/riscv-isa-manual/releases/download/riscv-isa-rele=
ase-8abdb41-2024-03-26/unpriv-isa-asciidoc.pdf # [1]
> Reported-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: Vineet Gupta <vgupta@kernel.org>
> Fixes: c2a658d41924 ("riscv: lib: vectorize =
copy_to_user/copy_from_user")
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/kernel/signal.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 501e66debf69..5a2edd7f027e 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -119,6 +119,13 @@ static long __restore_v_state(struct pt_regs =
*regs, void __user *sc_vec)
>  	struct __sc_riscv_v_state __user *state =3D sc_vec;
>  	void __user *datap;
>  +	/*
> +	 * Mark the vstate as clean prior performing the actual copy,
> +	 * to avoid getting the vstate incorrectly clobbered by the
> +	 *  discarded vector state.
> +	 */
> +	riscv_v_vstate_set_restore(current, regs);
> +
>  	/* Copy everything of __sc_riscv_v_state except datap. */
>  	err =3D __copy_from_user(&current->thread.vstate, =
&state->v_state,
>  			       offsetof(struct __riscv_v_ext_state, =
datap));
> @@ -133,13 +140,7 @@ static long __restore_v_state(struct pt_regs =
*regs, void __user *sc_vec)
>  	 * Copy the whole vector content from user space datap. Use
>  	 * copy_from_user to prevent information leak.
>  	 */
> -	err =3D copy_from_user(current->thread.vstate.datap, datap, =
riscv_v_vsize);
> -	if (unlikely(err))
> -		return err;
> -
> -	riscv_v_vstate_set_restore(current, regs);
> -
> -	return err;
> +	return copy_from_user(current->thread.vstate.datap, datap, =
riscv_v_vsize);
>  }
>  #else
>  #define save_v_state(task, regs) (0)
> base-commit: 7115ff4a8bfed3b9294bad2e111744e6abeadf1a


