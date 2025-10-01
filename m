Return-Path: <stable+bounces-182954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207E6BB0933
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 15:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0B03BB0BF
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154302FC87F;
	Wed,  1 Oct 2025 13:52:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC952FC86F
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326772; cv=none; b=c1L8zhmQz7etPnAMILYaXSDATYGKHifvwP/xIKB9vIkdxwYX8E3KV8u1ciRjOcKMtaG7sEsSf7pmA8RIWOodzNuL3n1CKXdkF4kC662x2TU2bOyF1yNyCkvBCsx3kSVdeX4lmBekkTDBskeeBFtof+ZPC4JKW8wEyxo4785vF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326772; c=relaxed/simple;
	bh=Oq+52jxImTyJ0VVI2SkENHGrSlTmjidIJcsFHz20+qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqlgJVQzPOUtX7c2DqaOO7PV7YLEs+i1LpVEpGL91FKhPjumfusQONJdIfvF2FXhtGgYNVPLmjAFvQdD810dl9692o7inu6eY3POu1gYx+FYVf3DcSPJ5VaPw3BZzpxukt0bgMaMhnsnaMUeVaTVWM125E+JsytKRC7R2q+b7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b403bb7843eso647697266b.3
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 06:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326769; x=1759931569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9xo26d+Fc9H/00o4d0bAiRwwNt+lCw1gwe3O/vn05I=;
        b=ryhehMYHk+pc9Go2+dQlfyw7Cl6AgvYYJR6Jg4Ig1O+VsiZS+FxaTbS/R/yOSBFydt
         7Hy2dHy+eFz9TPj9CGFtoeQQkVNx+urNb5fwPNJm8CIF3ePvIDy8n9k88zRI07GWyU5E
         uh0GoIIzhnZ7T0Dfwxl21vQMvQsU7uBldUvRP/FivKJjscGQbSTr5uWnn3i0KSS7JAQ+
         PoD5mp0jVpwmFq1ybu01nyTBTgGr+egRho4pTh9yIA7e5Q/0kiK4J/ffVTMDoSc7OPGV
         YorJdvFYntamN3h0uyWMcgvXQrU5FibbWOX9lDrvZ9p8HJg/iYs8Ekg/eJW142eKBgLk
         XL+A==
X-Forwarded-Encrypted: i=1; AJvYcCV5EMh/ZzUecfdisbjIrShZekSrfyw7F6Lc7c57X5yxXoNQioq1GqqlkNhjrEDAPU7tzrq2KIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5Kgg3u04RN3wr0wiezLmdZTWqPeIwYitW1KFlDJj8aZ6zH2Z
	1Doj/y7bgcSn7pWBzZrZbJIfWWezveJgvgj5CX60yj5f9PE4cP1RFifj
X-Gm-Gg: ASbGnct3kH+QZK4j1RVamS+e0V21IVXJk4NrqdVtK1/NGc6NPpCmx5XRKQ+AqEaG3Pp
	ezSU2wpLuMYbmDwfbkPJoDjVQ/uG1reEn6PBUszXu/A+K+iAa9LTRe60KPncrFLq/4HpC1mfdeG
	J2adrHd9tJz6J7RqLANxSm0TzjzhwgyIgIr88MKMCFdcuLrAJEv3NbXkfNP/zKUF6wTtJq9n9d+
	hPJRX6gbm/YCDBkimiYetT6k4MGH44jkSX3awTILwMlbJbcmAx9pzjg01tqVZbvNjQH6cvaFYNw
	oVTaMRHlaH2S5Vi11javjk8fhnlkP0yd7YLPbUG4Jb9kRCOKcx8b1uJuOIjP9BjbJHI8+HWjTBc
	v1xv1xjxEHXZxefxf88zCYSqLQLNmcQn1PnWUeqgTMVljDOlT
X-Google-Smtp-Source: AGHT+IG8YpPWuZpqMANKLXAfkVXIHpdaGaAmldTVKSM1mifUq5tEZTOrDjIs80DN1DUZ9MtkCuohQQ==
X-Received: by 2002:a17:907:724b:b0:b3f:cc6d:e0a8 with SMTP id a640c23a62f3a-b46e51687abmr512135166b.17.1759326769076;
        Wed, 01 Oct 2025 06:52:49 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f8aed6f31sm600742566b.74.2025.10.01.06.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 06:52:48 -0700 (PDT)
Date: Wed, 1 Oct 2025 06:52:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
Message-ID: <osebrhmk7i5w2yrqtuwubssak52hk66xxzjoyq3w6vwaqb4a5a@3xbh6dh2wuxt>
References: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
 <ea7cd581-d6cd-4b0d-986c-d0b43b613858@csgroup.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea7cd581-d6cd-4b0d-986c-d0b43b613858@csgroup.eu>

Hello Christophe,

On Mon, Sep 29, 2025 at 07:01:43PM +0200, Christophe Leroy wrote:
> Le 29/09/2025 à 11:15, Breno Leitao a écrit :
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index e286c197d7167..55abc5e17b8b1 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -786,6 +786,9 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
> >   static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
> >   {
> > +	if (!dev->aer_info)
> > +		return 1;
> > +
> 
> This is a static function, it cannot be called from outside aer.c . Why do
> you need such a check ?

I have more than 5 hosts crash in recent kernel due to this issue. This
is causing real crashes.

	[30745.821301] [ T964809] BUG: kernel NULL pointer dereference, address: 0000000000000264
	[30745.835249] [ T964809] #PF: supervisor read access in kernel mode
	[30745.845541] [ T964809] #PF: error_code(0x0000) - not-present page
	[30745.855831] [ T964809] PGD 7a26aa067 P4D 7a26aa067 PUD 2a807a067 PMD 0
	[30745.867267] [ T964809] Oops: Oops: 0000 [#1] SMP
	[30745.900469] [ T964809] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
	[30745.911999] [ T964809] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
	[30745.929557] [ T964809] Workqueue: events aer_recover_work_func
	[30745.939339] [     T964809] RIP: 0010:___ratelimit (lib/ratelimit.c:33)
	[30745.947896] [ T964809] Code: 89 06 48 8d 45 10 48 89 46 08 48 89 e0 48 89 46 10 48 89 df e8 18 48 0d 00 48 8d 65 f8 5b 5d c3 cc 55 41 57 41 56 41 54 53 50 <4c> 63 77 04 4d 85 f6 0f 9e c0 8b 5f 08 85 db 0f 9e c1 08 c1 80 f9
	All code
	========
	0:	89 06                	mov    %eax,(%rsi)
	2:	48 8d 45 10          	lea    0x10(%rbp),%rax
	6:	48 89 46 08          	mov    %rax,0x8(%rsi)
	a:	48 89 e0             	mov    %rsp,%rax
	d:	48 89 46 10          	mov    %rax,0x10(%rsi)
	11:	48 89 df             	mov    %rbx,%rdi
	14:	e8 18 48 0d 00       	call   0xd4831
	19:	48 8d 65 f8          	lea    -0x8(%rbp),%rsp
	1d:	5b                   	pop    %rbx
	1e:	5d                   	pop    %rbp
	1f:	c3                   	ret
	20:	cc                   	int3
	21:	55                   	push   %rbp
	22:	41 57                	push   %r15
	24:	41 56                	push   %r14
	26:	41 54                	push   %r12
	28:	53                   	push   %rbx
	29:	50                   	push   %rax
	2a:*	4c 63 77 04          	movslq 0x4(%rdi),%r14		<-- trapping instruction
	2e:	4d 85 f6             	test   %r14,%r14
	31:	0f 9e c0             	setle  %al
	34:	8b 5f 08             	mov    0x8(%rdi),%ebx
	37:	85 db                	test   %ebx,%ebx
	39:	0f 9e c1             	setle  %cl
	3c:	08 c1                	or     %al,%cl
	3e:	80                   	.byte 0x80
	3f:	f9                   	stc

	Code starting with the faulting instruction
	===========================================
	0:	4c 63 77 04          	movslq 0x4(%rdi),%r14
	4:	4d 85 f6             	test   %r14,%r14
	7:	0f 9e c0             	setle  %al
	a:	8b 5f 08             	mov    0x8(%rdi),%ebx
	d:	85 db                	test   %ebx,%ebx
	f:	0f 9e c1             	setle  %cl
	12:	08 c1                	or     %al,%cl
	14:	80                   	.byte 0x80
	15:	f9                   	stc
	[30745.985517] [ T964809] RSP: 0018:ffffc9002a10fc88 EFLAGS: 00010206
	[30745.996094] [ T964809] RAX: 0000000000000002 RBX: 0000000000000002 RCX: ffffffff8260c509
	[30746.010396] [ T964809] RDX: 0000000000000000 RSI: ffffffff825f37b7 RDI: 0000000000000260
	[30746.024710] [ T964809] RBP: 0000000000000000 R08: 8080808080808080 R09: 0000000000000000
	[30746.039044] [ T964809] R10: ffffc9002a10fcf0 R11: 8080000000000000 R12: 0000000000000000
	[30746.053349] [ T964809] R13: 0000000000000000 R14: ffff8882851f4000 R15: ffffc90000c312e0
	[30746.067649] [ T964809] FS:  0000000000000000(0000) GS:ffff8890fa91e000(0000) knlGS:0000000000000000
	[30746.083875] [ T964809] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[30746.095394] [ T964809] CR2: 0000000000000264 CR3: 00000008150b6002 CR4: 00000000007726f0
	[30746.109695] [ T964809] PKRU: 55555554
	[30746.115123] [ T964809] Call Trace:
	[30746.120028] [ T964809]  <TASK>
	[30746.124253] [     T964809] pci_print_aer (drivers/pci/pcie/aer.c:929)
	[30746.140335] [     T964809] aer_recover_work_func (drivers/pci/pcie/aer.c:1181)
	[30746.149070] [     T964809] process_scheduled_works (kernel/workqueue.c:3243 kernel/workqueue.c:3321)
	[30746.158326] [     T964809] ? worker_thread (kernel/workqueue.c:3355)
	[30746.166195] [     T964809] worker_thread (./include/linux/list.h:373 kernel/workqueue.c:946 kernel/workqueue.c:3403)
	[30746.173718] [     T964809] kthread (kernel/kthread.c:466)
	[30746.180018] [     T964809] ? kick_pool (kernel/workqueue.c:3348)
	[30746.187183] [     T964809] ? finish_task_switch (./include/linux/perf_event.h:? kernel/sched/core.c:5260)
	[30746.195911] [     T964809] ? housekeeping_affine (kernel/kthread.c:413)
	[30746.204502] [     T964809] ret_from_fork (arch/x86/kernel/process.c:154)
	[30746.211842] [     T964809] ? housekeeping_affine (kernel/kthread.c:413)
	[30746.220400] [     T964809] ret_from_fork_asm (arch/x86/entry/entry_64.S:258)


This stack is based on commit 038d61fd64227  ("Linux 6.16").

> I a check was to be made it should be in pci_aer_init() and in fact if
> kmalloc fails then all the probe should be made to fail.

Ok, the stack is not going through pci_aer_init(), but, through
aer_recover_work_func() -> pci_print_aer().

