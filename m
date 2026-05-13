Return-Path: <stable+bounces-246831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLNtCKJpBGpVIAIAu9opvQ
	(envelope-from <stable+bounces-246831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:08:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A58D532C3D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749A3308D418
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE63A71AF;
	Wed, 13 May 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6vUZFew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89937F00B;
	Wed, 13 May 2026 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673786; cv=none; b=TLfb3XysrICZsrXpCl832o6vP+MUl8Qg1XVzCXtjVEUW47Kw8dAkO62U9XPqEQBiMR1O6cttE+qBVx2tFtnvIUkTSm7LjTOHds1bj2N4MSUKJQK9icSuU5SWRlKAPuUy+Hy/qTougsF5TfjkVftTx3m4syx1eS+64Do7iAqdy5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673786; c=relaxed/simple;
	bh=wXYyIY2C38E8XT33svvE+VVML8KU7xZhhkDTjmZ4V4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn4YTqC6K0nEXfOGUCQ62xlyNDyMU2lFGv3sPaBE7erS2jK3fkgdAn9sPzE1PIzrBuog0hLxJE0N0meXy9OxQjyxu7XcDYQkLpLCT+4932dP/Bugi0Bv9AMNTXbadP1T9LJrOwZmghJxphA2CKHVHUfxfiUwLxaWlLygEiAZn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6vUZFew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAFFC2BCFA;
	Wed, 13 May 2026 12:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778673786;
	bh=wXYyIY2C38E8XT33svvE+VVML8KU7xZhhkDTjmZ4V4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6vUZFewjEEHOE9JbR3Sj1LGn9DZR0v3pW6lej2QPi1cTsYAp6MZZEE0VvcG9oOkC
	 5+H2XYss7L9lsWwgle4zmFIZ+as/KEtx4XJaqquLkZvg3UKjjeOAE9rHsb8/Q+PIdB
	 uh87APHo+RuYlRMPLA5d4TxWESHZ7P9Bl5YGgz5k=
Date: Wed, 13 May 2026 14:03:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Andy Chiu <andybnac@gmail.com>, Anup Patel <anup@brainfault.org>,
	Sherry Yang <sherry.yang@oracle.com>,
	Vijayendra Suman <vijayendra.suman@oracle.com>
Subject: Re: [PATCH 6.12 135/206] riscv: kvm: fix vector context allocation
 leak
Message-ID: <2026051304-shaded-overhand-a3f5@gregkh>
References: <20260512173932.810559588@linuxfoundation.org>
 <20260512173935.718950582@linuxfoundation.org>
 <cbda86eb-4896-4f35-bf76-3387ce14ca6b@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbda86eb-4896-4f35-bf76-3387ce14ca6b@oracle.com>
X-Rspamd-Queue-Id: 6A58D532C3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246831-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,brainfault.org,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 05:19:51PM +0530, Harshit Mogalapalli wrote:
> Hi  Greg,
> 
> On 12/05/26 23:09, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Osama Abdelkader <osama.abdelkader@gmail.com>
> > 
> > commit b7c958d7c1eb1cb9b2be7b5ee4129fcd66cec978 upstream.
> > 
> > When the second kzalloc (host_context.vector.datap) fails in
> > kvm_riscv_vcpu_alloc_vector_context, the first allocation
> > (guest_context.vector.datap) is leaked. Free it before returning.
> > 
> > Fixes: 0f4b82579716 ("riscv: KVM: Add vector lazy save/restore support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > Reviewed-by: Andy Chiu <andybnac@gmail.com>
> > Link: https://lore.kernel.org/r/20260316151612.13305-1-osama.abdelkader@gmail.com
> > Signed-off-by: Anup Patel <anup@brainfault.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   arch/riscv/kvm/vcpu_vector.c |    5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > --- a/arch/riscv/kvm/vcpu_vector.c
> > +++ b/arch/riscv/kvm/vcpu_vector.c
> > @@ -79,8 +79,11 @@ int kvm_riscv_vcpu_alloc_vector_context(
> >   	cntx->vector.vlenb = riscv_v_vsize / 32;
> >   	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
> > -	if (!vcpu->arch.host_context.vector.datap)
> > +	if (!vcpu->arch.host_context.vector.datap) {
> > +		kfree(vcpu->arch.guest_context.vector.datap);
> > +		vcpu->arch.guest_context.vector.datap = NULL;
> >   		return -ENOMEM;
> > +	}
> 
> I have run an AI assisted backport review and it spotted an issue: I
> have taken a look and the issues goes like:
> 
> 
> Upstream does:
> 
> index 05f3cc2d8e31..5b6ad82d47be 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -76,12 +76,15 @@ void kvm_riscv_vcpu_host_vector_restore(struct
> kvm_cpu_context *cntx)
>  int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
>  {
>         vcpu->arch.guest_context.vector.datap = kzalloc(riscv_v_vsize,
> GFP_KERNEL);
>         if (!vcpu->arch.guest_context.vector.datap)
>                 return -ENOMEM;
> 
>         vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize,
> GFP_KERNEL);
> -       if (!vcpu->arch.host_context.vector.datap)
> +       if (!vcpu->arch.host_context.vector.datap) {
> +               kfree(vcpu->arch.guest_context.vector.datap);
> +               vcpu->arch.guest_context.vector.datap = NULL;
>                 return -ENOMEM;
> +       }
> 
>         return 0;
> 
> So when second allocation fails in the error path, its frees the right
> object "vcpu->arch.guest_context.vector.datap"
> 
> but in the backport:
> 
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 8454c1c3655a..eaf88c20508a 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -73,14 +73,17 @@ void kvm_riscv_vcpu_host_vector_restore(struct
> kvm_cpu_context *cntx)
>  int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu,
>                                         struct kvm_cpu_context *cntx)
>  {
>         cntx->vector.datap = kmalloc(riscv_v_vsize, GFP_KERNEL);
>         if (!cntx->vector.datap)
>                 return -ENOMEM;
>         cntx->vector.vlenb = riscv_v_vsize / 32;
> 
>         vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize,
> GFP_KERNEL);
> -       if (!vcpu->arch.host_context.vector.datap)
> +       if (!vcpu->arch.host_context.vector.datap) {
> +               kfree(vcpu->arch.guest_context.vector.datap);
> +               vcpu->arch.guest_context.vector.datap = NULL;
>                 return -ENOMEM;
> +       }
> 
>         return 0;
>  }
> 
> 
> we should have freed "cntx->vector.datap" but frees the same object like
> upstream.
> 
> So there is a cleanup target mismatch (cntx->vector.datap allocated,
> guest_context.vector.datap freed)
> 
> I think we need to drop this backport.

Now dropped, thanks!

greg k-h

