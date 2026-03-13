Return-Path: <stable+bounces-225384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yV/hJ+R2tGlHogAAu9opvQ
	(envelope-from <stable+bounces-225384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 21:43:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF25289DD3
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 21:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79ACB3020A42
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 20:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905A03D3D04;
	Fri, 13 Mar 2026 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="curyDYdy"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E739EF22;
	Fri, 13 Mar 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773434593; cv=none; b=FJ5+4a2p7X4AVCOnfFXLaBOpRaHv+gmOXUed0sQihe/oYvAo5JVQIKEaCKnlIfruTgplKltIAG+4L7absbagjwiYXpcB62I32XcfhlFBAjbtPrUHWgCYER7hpo+l3KPC3gtM0WmeFsvHebU9U8x/C8TKU/urA/DgicNMrynpmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773434593; c=relaxed/simple;
	bh=9ihc3ObVU1jdn6AjGf+/TJIcduS4gQy/lZMlNP7z5Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2kJqq7mODcqf+QfTQhR+YJDAjj+ZPwyq+iVfZq5A2drerK6XT+8gEGVJJZylv13KM95UHhcWVbKZDcqukBS6zvi/lhPBqmM5GKD9KjZioseMR4KWG2I3gy0+x62B0GsABWAgdhsRiMM8GZ2+NxkbxmHvD9rAsTbThFodL30Hrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=curyDYdy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E9F7040E01D2;
	Fri, 13 Mar 2026 20:43:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id df0A_RpuSWSF; Fri, 13 Mar 2026 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773434583; bh=118vG4IRxyg/u7hvdZvxPs+MMZw9lt+3EYVU7R8pt1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=curyDYdyHTwNmBkvjqQlmU2lPa5pvMLaKWl8eX3O/P5h/dS9iKr2C2u70BCyt0ypc
	 Evr8r/xhS/epMEcYYGvfhs5kxbrUh08g529v6tUg0SuUW9Wff/dcPoE2iQ0g9SDpcq
	 urxeBtdEyl/Ek6dhDkgouL47KGu7zt+LlhgMPR69EcP3avGgAUyFv/tGzv008dc3SK
	 OHhvuPaw2rC3LS/vsaEa7m+axr+H+PDQpce8ix78/44OH3q6ZHmL+9sVbqJcrpt3hg
	 jiu7dovnmE2uX9JOgX+zcotngMZNpYYCHMLlnnaQO+R+AOjcSFH0DnUp0roE3SZVbQ
	 hzb05Nk2ql30sbCw7ndQLTepUlydNCkm95Cn96VfrDFTPOtOakcCNmPrf8ZtNTczeR
	 G4qUTsRkhtf8GcAN3MyfiKcy6Z36VwNRnBsk2IMdGglrgttHmQnyC+V/hbcRpSfXsG
	 HJOj0IOsPtYaP3MF8TNe0KCHVPmVKHi/3rm0D75JOv74sR2MnYdR5z6TW0UtPifJr0
	 eHZf36UpL33qnMU3FbUEZjL2fR2Rt8KhOVRUkP7YFBr7LEB9IS1lJJpUpo/Eh/lIPn
	 i1u1fhcvgxKg9ppuRWHPAb0O+2uNUiL3kAyhTp+41nuhGv9Nt5L+WH0N3tdWuV6enL
	 SD/j57Bg16vGdoN/vXU0nf7Q=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7DBB240E016B;
	Fri, 13 Mar 2026 20:42:49 +0000 (UTC)
Date: Fri, 13 Mar 2026 21:42:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Fix NULL dereference for missing
 hugepagesz/hugepages value
Message-ID: <20260313204243.GIabR2w3PqVcFxg66B@fat_crate.local>
References: <20260302205901.39610-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302205901.39610-1-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225384-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fat_crate.local:mid,linux.dev:email,alien8.de:dkim]
X-Rspamd-Queue-Id: 3BF25289DD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 02, 2026 at 09:58:59PM +0100, Thorsten Blum wrote:
> In parse_gb_huge_pages(), 'val' can be NULL if '=' is missing from the
> boot parameter. The code passes 'val' to memparse() and
> simple_strtoull(), which can dereference NULL.
> 
> Reject 'hugepagesz' and 'hugepages' when no value has been provided and
> log a warning.
> 
> Fixes: 9b912485e0e7 ("x86/boot/KASLR: Add two new functions for 1GB huge pages handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/x86/boot/compressed/kaslr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 3b0948ad449f..88ccc3b2c5aa 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -205,6 +205,11 @@ static void parse_gb_huge_pages(char *param, char *val)
>  	char *p;
>  
>  	if (!strcmp(param, "hugepagesz")) {
> +		if (!val) {
> +			warn("Missing value in hugepagesz= boot parameter\n");
> +			return;
> +		}
> +
>  		p = val;
>  		if (memparse(p, &p) != PUD_SIZE) {
>  			gbpage_sz = false;
> @@ -218,6 +223,11 @@ static void parse_gb_huge_pages(char *param, char *val)
>  	}
>  
>  	if (!strcmp(param, "hugepages") && gbpage_sz) {
> +		if (!val) {
> +			warn("Missing value in hugepages= boot parameter\n");
> +			return;
> +		}
> +
>  		p = val;
>  		max_gb_huge_pages = simple_strtoull(p, &p, 0);
>  		return;

The intent is good even if it is not working fully yet, see below.

That's with

[    0.000000] Command line: root=/dev/sda2 resume=/dev/sda3 debug ignore_loglevel log_buf_len=16M earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 no_console_suspend nokaslr no_hash_pointers sysrq_always_enabled net.ifnames=0 hugepagesz

on the cmdline.

And that happens even without your kaslr.c changes because I have

# CONFIG_RANDOMIZE_BASE is not set

So it looks like there's more crap in the parsing of those two options.

Also, while at it, you probably wanna add this:

---
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 88ccc3b2c5aa..e041be5e4326 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -206,8 +206,8 @@ static void parse_gb_huge_pages(char *param, char *val)
 
 	if (!strcmp(param, "hugepagesz")) {
 		if (!val) {
-			warn("Missing value in hugepagesz= boot parameter\n");
-			return;
+			warn("No value supplied with hugepagesz= boot parameter\n");
+			goto next;
 		}
 
 		p = val;
@@ -222,9 +222,10 @@ static void parse_gb_huge_pages(char *param, char *val)
 		return;
 	}
 
+next:
 	if (!strcmp(param, "hugepages") && gbpage_sz) {
 		if (!val) {
-			warn("Missing value in hugepages= boot parameter\n");
+			warn("No value supplied with hugepages= boot parameter\n");
 			return;
 		}

---

I'm not sure what the logic is wrt allowing *both* cmdline options or
separately or whatnot.
 
In any case, I'd appreciate it if you take the time and whack all those
possible snafus with parsing hugepage* options so that we're solid there.

Thx!

---
PANIC: early exception 0x0e IP 10:ffffffff81d1e014 error 0 cr2 0x0
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.0.0-rc3+ #1 PREEMPT(undef) 
[    0.000000] RIP: 0010:strlen+0x4/0x30
[    0.000000] Code: f7 75 ec 31 c0 e9 bc 6a 02 00 48 89 f8 e9 b4 6a 02 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <80> 3f 00 74 18 48 89 f8 0f 1f 40 00 48 83 c0 01 80 38 00 75 f7 48
[    0.000000] RSP: 0000:ffffffff82403dc0 EFLAGS: 00010097 ORIG_RAX: 0000000000000000
[    0.000000] RAX: ffffffff899c5a70 RBX: 0000000000000000 RCX: 00000000ffffffea
[    0.000000] RDX: 0000000000000000 RSI: ffffffff899c6100 RDI: 0000000000000000
[    0.000000] RBP: 0000000000000000 R08: ffffffff899fe170 R09: 0000000000000000
[    0.000000] R10: ffffffff82403e40 R11: ffffffff82403e38 R12: ffffffff899c6100
[    0.000000] R13: 000000000000005f R14: ffffffff899fe17a R15: ffffffff899fe170
[    0.000000] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: 0000000000000000 CR3: 000000000a208000 CR4: 00000000000000f0
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000]  ? hugetlb_add_param+0x24/0x90
[    0.000000]  ? do_early_param+0x44/0x70
[    0.000000]  ? parse_args+0x146/0x410
[    0.000000]  ? _printk+0x4c/0x60
[    0.000000]  ? parse_early_options+0x29/0x30
[    0.000000]  ? __pfx_do_early_param+0x10/0x10
[    0.000000]  ? parse_early_param+0x36/0x90
[    0.000000]  ? setup_arch+0x47b/0xa90
[    0.000000]  ? _printk+0x4c/0x60
[    0.000000]  ? start_kernel+0x56/0x770
[    0.000000]  ? x86_64_start_reservations+0x24/0x30
[    0.000000]  ? x86_64_start_kernel+0xd6/0xe0
[    0.000000]  ? common_startup_64+0x13e/0x141
[    0.000000]  </TASK>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

