Return-Path: <stable+bounces-227213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDJdJleau2nwlgIAu9opvQ
	(envelope-from <stable+bounces-227213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:40:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD42C6E1D
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD76E3067433
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 06:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0721346A11;
	Thu, 19 Mar 2026 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qE4xaQgE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ADD10E3;
	Thu, 19 Mar 2026 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773902414; cv=none; b=D/+tMPpEr9r6QyNp8CLkx3YHaUTsKY3wXkzwdjB7yaBfH1IAKfdHTO767UAqjbaxOghaaOfv9FAKLO3ZXHY+bwFQIJwq2KaachOgFLd3jm1/EAlu/BaMzJvmM4UKmDw545m5kcbT4GXDfCfVARtZyAMuuj/yNYGp08fh28MPL08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773902414; c=relaxed/simple;
	bh=X9L49s7yEBoJxFTNA1J/pynK8VJPzrAxAQkztnEd9no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki8Wkt3fJDu7eZUC5/JlccbdB4gkegVGUAA041BgoekPmxnGcxaC/SPSc4yOBVDGptqLitGyjgHfdAa1qysgBxg0N00pqImkrHu+lbAPxiVhEnl70k2q25+/r3AlFwMPGFNhPjPG54Dkiqy+HiXOpU61YixcbPU13UwwDRhcYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qE4xaQgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095C3C19425;
	Thu, 19 Mar 2026 06:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773902414;
	bh=X9L49s7yEBoJxFTNA1J/pynK8VJPzrAxAQkztnEd9no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qE4xaQgEoQSrXGqL4bSi0CCuq6Dl27pCxcKN6vHpsK9qKeE15yQinCUUb7n87/7r1
	 ncyzfjkxZdQqGcBDvgphlfIzVAuIhWoG1+yETlTu0yGSX19vJpgWMk/fuUo81fBKjW
	 RVg+NLPaum5bk0Jwy4nHxD2LdO5znV+AGeGe2umg=
Date: Thu, 19 Mar 2026 07:40:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel J Blueman <daniel@quora.org>
Cc: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Thorsten Blum <thorsten.blum@linux.dev>, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] apparmor: Fix string overrun due to missing termination
Message-ID: <2026031904-default-staining-0240@gregkh>
References: <20260319062433.17648-1-daniel@quora.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319062433.17648-1-daniel@quora.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227213-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.847];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quora.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F3AD42C6E1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 02:24:32PM +0800, Daniel J Blueman wrote:
> When booting Ubuntu 26.04 with Linux 7.0-rc4 on an ARM64 Qualcomm
> Snapdragon X1 we see a string buffer overrun:
> 
> BUG: KASAN: slab-out-of-bounds in aa_dfa_match (security/apparmor/match.c:535)
> Read of size 1 at addr ffff0008901cc000 by task snap-update-ns/2120
> 
> CPU: 5 UID: 60578 PID: 2120 Comm: snap-update-ns Not tainted 7.0.0-rc4+ #22 PREEMPTLAZY
> Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN60WW 09/11/2025
> Call trace:
> show_stack (arch/arm64/kernel/stacktrace.c:501) (C)
> dump_stack_lvl (lib/dump_stack.c:122)
> print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
> kasan_report (mm/kasan/report.c:597)
> __asan_report_load1_noabort (mm/kasan/report_generic.c:378)
> aa_dfa_match (security/apparmor/match.c:535)
> match_mnt_path_str (security/apparmor/mount.c:244 security/apparmor/mount.c:336)
> match_mnt (security/apparmor/mount.c:371)
> aa_bind_mount (security/apparmor/mount.c:447 (discriminator 4))
> apparmor_sb_mount (security/apparmor/lsm.c:719 (discriminator 1))
> security_sb_mount (security/security.c:1062 (discriminator 31))
> path_mount (fs/namespace.c:4101)
> __arm64_sys_mount (fs/namespace.c:4172 fs/namespace.c:4361 fs/namespace.c:4338 fs/namespace.c:4338)
> invoke_syscall.constprop.0 (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
> el0_svc_common.constprop.0 (./include/linux/thread_info.h:142 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
> do_el0_svc (arch/arm64/kernel/syscall.c:152)
> el0_svc (arch/arm64/kernel/entry-common.c:80 arch/arm64/kernel/entry-common.c:725)
> el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:744)
> el0t_64_sync (arch/arm64/kernel/entry.S:596)
> 
> Allocated by task 2120:
> kasan_save_stack (mm/kasan/common.c:58)
> kasan_save_track (./arch/arm64/include/asm/current.h:19 mm/kasan/common.c:70 mm/kasan/common.c:79)
> kasan_save_alloc_info (mm/kasan/generic.c:571)
> __kasan_kmalloc (mm/kasan/common.c:419)
> __kmalloc_noprof (./include/linux/kasan.h:263 mm/slub.c:5260 mm/slub.c:5272)
> aa_get_buffer (security/apparmor/lsm.c:2201)
> aa_bind_mount (security/apparmor/mount.c:442)
> apparmor_sb_mount (security/apparmor/lsm.c:719 (discriminator 1))
> security_sb_mount (security/security.c:1062 (discriminator 31))
> path_mount (fs/namespace.c:4101)
> __arm64_sys_mount (fs/namespace.c:4172 fs/namespace.c:4361 fs/namespace.c:4338 fs/namespace.c:4338)
> invoke_syscall.constprop.0 (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
> el0_svc_common.constprop.0 (./include/linux/thread_info.h:142 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
> do_el0_svc (arch/arm64/kernel/syscall.c:152)
> el0_svc (arch/arm64/kernel/entry-common.c:80 arch/arm64/kernel/entry-common.c:725)
> el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:744)
> el0t_64_sync (arch/arm64/kernel/entry.S:596)
> 
> The buggy address belongs to the object at ffff0008901ca000
> which belongs to the cache kmalloc-rnd-06-8k of size 8192
> The buggy address is located 0 bytes to the right of
> allocated 8192-byte region [ffff0008901ca000, ffff0008901cc000)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9101c8
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:-1 pincount:0
> flags: 0x8000000000000040(head|zone=2)
> page_type: f5(slab)
> raw: 8000000000000040 ffff000800016c40 fffffdffe2d14e10 ffff000800015c70
> raw: 0000000000000000 0000000800010001 00000000f5000000 0000000000000000
> head: 8000000000000040 ffff000800016c40 fffffdffe2d14e10 ffff000800015c70
> head: 0000000000000000 0000000800010001 00000000f5000000 0000000000000000
> head: 8000000000000003 fffffdffe2407201 fffffdffffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
> ffff0008901cbf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff0008901cbf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff0008901cc000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ^
> ffff0008901cc080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff0008901cc100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> 
> This was introduced by previous incorrect conversion from strcpy(). Fix it
> by adding the missing terminator.
> 
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> Fixes: 93d4dbdc8da0 ("apparmor: Replace deprecated strcpy in d_namespace_path")
> ---
>  security/apparmor/path.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/path.c b/security/apparmor/path.c
> index 65a0ca5cc1bd..2494e8101538 100644
> --- a/security/apparmor/path.c
> +++ b/security/apparmor/path.c
> @@ -164,14 +164,16 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
>  	}
>  
>  out:
> -	/* Append "/" to directory paths, except for root "/" which
> -	 * already ends in a slash.
> +	/* Append "/" to directory paths and reterminate string, except for
> +	 * root "/" which already ends in a slash.
>  	 */
>  	if (!error && isdir) {
>  		bool is_root = (*name)[0] == '/' && (*name)[1] == '\0';
>  
> -		if (!is_root)
> +		if (!is_root) {
>  			buf[aa_g_path_max - 2] = '/';
> +			buf[aa_g_path_max - 1] = '\0';
> +		}
>  	}
>  
>  	return error;
> -- 
> 2.53.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

