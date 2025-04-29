Return-Path: <stable+bounces-137102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FABAA0E9F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3841B600D0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F482D3205;
	Tue, 29 Apr 2025 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="nrBrd94S"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-3.centrum.cz (gmmr-3.centrum.cz [46.255.225.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22A1F76A5;
	Tue, 29 Apr 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.225.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936584; cv=none; b=L5iU2UWfhwAcDCf0cF6+UDGuLfpvLGXU5Qi8PJp2+O0M39KEUPaGHrfpPgisZjVJLUO6uSRsiXAAU/iPJemKLzx8J2ajPfeK2ByizRYQaCUgCXYKUz2INBxHrGEmaRb2XgR9Y1RQjoT0ZFl32rysLpgQ3k/vo+xcamrQu3sRzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936584; c=relaxed/simple;
	bh=rRpCkUF+vCL5Wzdq2xxwkjXQnIKw0HmuK4vE3i14w7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LUuvZVNU3M6VUuPUoWCS3F9u6IOW6UdsCE8Utu9x+5cxnvrou1KRayl88Ra9ukkvjhxCBYCm0paE1MsVxh+G7zneGcSh91H7WnEXm1O8UbI7Z/ZjLxNTvw/3yEHqsjpp7Ny65w3Trg5DVQSjKPiAxyj4ngyfbPxRgytWhOvO9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=nrBrd94S; arc=none smtp.client-ip=46.255.225.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-3.centrum.cz (localhost [127.0.0.1])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 8DCFF20320DD;
	Tue, 29 Apr 2025 16:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1745936571; bh=27BxSawsDTpmtQopOmEMuk8bqM4mrWb7IAxrUPyws5A=;
	h=From:To:Cc:Subject:Date:From;
	b=nrBrd94S3DOUoa4MYb8I51iy6z0n1ba3QOkhYWf72b3+53KOh1SOdEei8OF0btki/
	 dtJ2OFZzPIs7Sknww2VzXZY5bSykNEkMCDSrKHn2RGOmK7lW4lNcoVZXgKxlFXyNAZ
	 aIj+nYkKmliwFdXnh7geefm2a4r+2voGCebceSgo=
Received: from antispam23.centrum.cz (antispam23.cent [10.30.208.23])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 899C220320FE;
	Tue, 29 Apr 2025 16:22:51 +0200 (CEST)
X-CSE-ConnectionGUID: mJtWwQDJT2+6ktytlqCXSA==
X-CSE-MsgGUID: p5WUAkcYQ3W2PGgrxng0rQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2HDAADU3xBo/03h/y5aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAJgUqDNIZGkXGBFopjhVFijWkPAQEBAQEBAQEBCUQEAQE+AYQ+Cos1J?=
 =?us-ascii?q?zgTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQYBAQEBAQEGBgECgR2FNVOCYgGEK?=
 =?us-ascii?q?Q8BRigNAiYCg3OCMAE0smWBMhoCZdxwAoEjZIEpgRsuiFABhHxvAYU5gg2BF?=
 =?us-ascii?q?YJyB2+BBQGHGIJpBIItgQIUiieDEoVVixJIgQUcA1ksAVUTDQoLBwWBaQM1D?=
 =?us-ascii?q?AsuFTI8Mx2CEYUhghGCBIkKhFAtT4UxgSUdQAMLGA1IESw3FBsGPQFuB5knB?=
 =?us-ascii?q?wGBDUyBJQiUG5AHoyiEJYROnHsaM5dSHgOSZJh+G6MVZTeEaYF+gX8zIjCDI?=
 =?us-ascii?q?1EZjjkDBAcLvCmBMgIHAQoBAQMJgjuNYWtgAQE?=
IronPort-PHdr: A9a23:+7BlJRHXFR/aWvjQe7I5YZ1Gf0RKhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k21hmRBc6Bta4c16L/iOPJZy8p2d65qncMcZhBBVcuqP49uEgNJvDAImDAaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 RuooQnLqsUanYRuJrgwxxbGvndFdPldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U
 7NVCSktPn426sP2qxTNVBOD6HQEXGoZixZFHQfL4gziUpj+riX1uOx92DKHPcLtVrA7RS6i7
 6ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWWROQNpeVy1ZAoO9c
 YQPCfYBPf1FpIX5vlcCsAeyCRWpCO7p1zRGhGL53bci3uohDw/LwhEuEdwNvnrTo9r6KKgcX
 PupzKTL1zjPc+lb1Sv/5YXObxsvoeuMXbV1ccfJ00cgCR/Fjk+NooPqJTyV0PoIs2uG5OdnT
 +2vkW0npBt0oje13MchkZPGhp4Ryl/e7iV12po6JNyhRUN9fNWrH4deuTuAOItqXsMtXXtou
 CAix7AapZK2eDYHxIknyhPRd/GKcoaF7gz9WeieLzl1mWxpdK+jihuw7EWt1+/xW8i13VtLr
 CdIk8TAu3AC2hHO68WKTOZ28ES52TuX2A3e6/tILV40mKfbMZIt3KA8m5oJvUnBHCL6gFv6g
 LKYe0k+5OSk9fjrbq/4qpKTK4N4kAXzP6Uol8eiG+o3KBIOUHKe+emk0b3j+lD2T6tSg/0tl
 6nZrIjaJcMGpq6lGwNV0pgs6xK4Dzq+39QYmGALLElAeBKbl4jlJk3CLOrkAvihhVSsjC1rx
 +3DPrH7HprML2DPkLbnfblj905R0AU+wNFF655KCrwMIOj/VlHvuNHYFBM0MQ65z/7iCNpn1
 4MeXWyPArWeMKPXqVKH/PgvI+qWa48Qojn9MeMo6OTyjX89g1AdZrOl0ocWaXygBPRpP12ZY
 WbwgtcGCWoKpAo/Q/bsiFGYSz5TYG29ULwm5jEnE4KrFp3MRpqogLCbwCi7GZhWanhcCl+QC
 Xfoa5mEW/AUZS2IOM9hkSYLVb27RI87zhyhrhP6y759IerP4CEXqZPi2MBv5+LPjREy6SB0D
 8OF3mGJTmF0mH4IRjAv0KB6pExw0VSD0bZijPNEFtxf/fRJUh01NZLE1ex1F8jyWh7dfteOU
 FupWNamASk0Tt8qx98OYkB9G8itjxza0SqqBKIVl7qWC5Mu7qLc3n/xJ8Bnx3bBzqkhgEEqQ
 tFTOm2+mq5/6w/TCpbUnEqDiaaqdLkT0TXX9Gid0GWOvFtXUBJqXarZWnAfY1Parc7l6UPaU
 7+uFbMnPxNFyc6DLKtKd9LogUxFRPj9ItTeZXy+m2OrCBaWybODcpDqd38e3CrDEkgElR4c/
 XKcOQg5HCehrHrSDCZyGlL3f0Ps7e5+pWugTk8o1Q6FdElh2KSu9x4LivyTVekT0qgHuCg/s
 TV0Gkiy39bMB9qHvQphc71QYdUm71hfz2LWqxR9PoC8L6BlnlMTcVc/g0S70xRxF5UFksUwq
 n4u5BR9JLje015bcT6cm5fqNe75MG73qSiid7Se5FjYc9Xerq4V6/09ok/LtR2tH1Fk+Gcxg
 Iod6GeV+pifVFlaapn2SEtiskEi/9nn
IronPort-Data: A9a23:lyOliqmuCYgC4/USepH5QQzo5gxHJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJODWqHOv2IMDCmKt53O4u09RtVupKAndAwHQRlpSAxF1tH+JHPbTi7wuYcHM8wwunrFh8PA
 xA2M4GYRCwMZiaB4Erra/658CQUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dga++2k
 Y20+pC31GONgWYubzpIsfPb8nuDgdyr0N8mlg1jDRx0lACG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaPVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 ONl7sXsFFhzbsUgr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXADUvci+cvs6U/Oj4FOpwl9gnNeLbB6pK7xmMzRmBZRonaZ/GBr7P+ccBhHE7i8ZSB+vbI
 cELAdZtREieJUcSZxFNUs94w7jAanrXKlW0rHqcv6k+5mHJ5AVt1LH2dtHHEjCPbZ4MwRrE/
 TydoAwVBDkCaeOi4DmOw0v3ubX3sizhSIQdTKeBo6sCbFq7gzZ75ActfUGqqP//kEm0VshDM
 GQd4C9opq83nGSiVNr0WhSiiHeYuhcHHdFCe8U+6QeQ2u/R5i6aGGEPTXhGctNOnMY1XTkC0
 l6PgsOsCztytrGcVXOa8PGTtzzaESQcM24OTTUJQQsM/5/op4RbphbOSMtzVa24lNv4HRnuz
 D2Q6isznbMeiYgMzarT1Uvbijioq7DXQQMvoAbaRGSo6kV+foHNWmCzwQSFq6wdccDDFATH4
 ydsd9Wi0d3ixKqlzESlKNjh1pnyjxpZGFUwWWJSIqQ=
IronPort-HdrOrdr: A9a23:ufbKSahU84r5YcjFBxAysu/IC3BQXssji2hC6mlwRA09TyVXra
 yTdZMgpHrJYVcqKRMdcL+7VpVoLUm3yXcX2/hzAV7BZmjbUQKTRekI0WKI+VLd8kPFm9K1rZ
 0BT5RD
X-Talos-CUID: 9a23:nlqkoWEp+0O/PIvmqmJi1lIrBfkJUEGHjynTP16kDX9CeIa8HAo=
X-Talos-MUID: 9a23:QMLgtQVrf6hxY1rq/CexuwxLN8xZ2v+RUngino8WvcbcLxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,249,1739833200"; 
   d="scan'208";a="317443637"
Received: from unknown (HELO gm-smtp10.centrum.cz) ([46.255.225.77])
  by antispam23.centrum.cz with ESMTP; 29 Apr 2025 16:22:51 +0200
Received: from localhost.localdomain (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp10.centrum.cz (Postfix) with ESMTPSA id 1BAEA808C14C;
	Tue, 29 Apr 2025 16:22:51 +0200 (CEST)
From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
Subject: [PATCH 0/1] mm: Fix regression after THP PTE optimization on Xen PV Dom0
Date: Tue, 29 Apr 2025 16:22:36 +0200
Message-ID: <20250429142237.22138-1-arkamar@atlas.cz>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I have found a problem in recent kernels 6.9+ when running under the Xen
hypervisor as a PV dom0. In my setup (PV Dom0 with 4G RAM, using XFS), I
shrink memory to 256M via the balloon driver after boot:

  xl mem-set Domain-0 256m

Once memory is reduced, even running a simple command like ls usually
triggers the following warning:

[   27.963562] [ T2553] page: refcount:88 mapcount:21 mapping:ffff88813ff6f6a8 index:0x110 pfn:0x10085c
[   27.963564] [ T2553] head: order:2 mapcount:83 entire_mapcount:0 nr_pages_mapped:4 pincount:0
[   27.963565] [ T2553] memcg:ffff888003573000
[   27.963567] [ T2553] aops:0xffffffff8226fd20 ino:82467c dentry name(?):"libc.so.6"
[   27.963570] [ T2553] flags: 0x2000000000416c(referenced|uptodate|lru|active|private|head|node=0|zone=2)
[   27.963573] [ T2553] raw: 002000000000416c ffffea0004021e88 ffffea0004021908 ffff88813ff6f6a8
[   27.963574] [ T2553] raw: 0000000000000110 ffff88811bf06b60 0000005800000014 ffff888003573000
[   27.963576] [ T2553] head: 002000000000416c ffffea0004021e88 ffffea0004021908 ffff88813ff6f6a8
[   27.963577] [ T2553] head: 0000000000000110 ffff88811bf06b60 0000005800000014 ffff888003573000
[   27.963578] [ T2553] head: 0020000000000202 ffffea0004021701 0000000400000052 00000000ffffffff
[   27.963580] [ T2553] head: 0000000300000003 8000000300000002 0000000000000014 0000000000000004
[   27.963581] [ T2553] page dumped because: VM_WARN_ON_FOLIO((_Generic((page + nr_pages - 1), const struct page *: (const struct folio *)_compound_head(page + nr_pages - 1), struct page *: (struct folio *)_compound_head(page + nr_pages - 1))) != folio)
[   27.963590] [ T2553] ------------[ cut here ]------------
[   27.963591] [ T2553] WARNING: CPU: 1 PID: 2553 at include/linux/rmap.h:427 __folio_rmap_sanity_checks+0x1a0/0x270
[   27.963596] [ T2553] CPU: 1 UID: 0 PID: 2553 Comm: ls Not tainted 6.15.0-rc4-00002-ge0363f942651 #270 PREEMPT(undef)
[   27.963599] [ T2553] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
[   27.963601] [ T2553] RIP: e030:__folio_rmap_sanity_checks+0x1a0/0x270
[   27.963603] [ T2553] Code: 89 df e8 b3 7d fd ff 0f 0b e9 eb fe ff ff 48 8d 42 ff 48 39 c3 0f 84 0e ff ff ff 48 c7 c6 e8 49 5b 82 48 89 df e8 90 7d fd ff <0f> 0b e9 f8 fe ff ff 41 f7 c4 ff 0f 00 00 0f 85 b2 fe ff ff 49 8b
[   27.963605] [ T2553] RSP: e02b:ffffc90040f8fac0 EFLAGS: 00010246
[   27.963608] [ T2553] RAX: 00000000000000e5 RBX: ffffea0004021700 RCX: 0000000000000000
[   27.963609] [ T2553] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000ffffffff
[   27.963610] [ T2553] RBP: ffffc90040f8fae0 R08: 00000000ffffdfff R09: ffffffff82929308
[   27.963612] [ T2553] R10: ffffffff82879360 R11: 0000000000000002 R12: ffffea0004021700
[   27.963613] [ T2553] R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000005
[   27.963625] [ T2553] FS:  00007ff06dafe740(0000) GS:ffff8880b7ccb000(0000) knlGS:0000000000000000
[   27.963627] [ T2553] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.963628] [ T2553] CR2: 000055deb932f630 CR3: 0000000002844000 CR4: 0000000000050660
[   27.963630] [ T2553] Call Trace:
[   27.963632] [ T2553]  <TASK>
[   27.963633] [ T2553]  folio_remove_rmap_ptes+0x24/0x2b0
[   27.963635] [ T2553]  unmap_page_range+0x132e/0x17e0
[   27.963638] [ T2553]  unmap_single_vma+0x81/0xd0
[   27.963640] [ T2553]  unmap_vmas+0xb5/0x180
[   27.963642] [ T2553]  exit_mmap+0x10c/0x460
[   27.963644] [ T2553]  mmput+0x59/0x120
[   27.963647] [ T2553]  do_exit+0x2d1/0xbd0
[   27.963649] [ T2553]  do_group_exit+0x2f/0x90
[   27.963651] [ T2553]  __x64_sys_exit_group+0x13/0x20
[   27.963652] [ T2553]  x64_sys_call+0x126b/0x1d70
[   27.963655] [ T2553]  do_syscall_64+0x54/0x120
[   27.963657] [ T2553]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   27.963659] [ T2553] RIP: 0033:0x7ff06dbdbe9d
[   27.963660] [ T2553] Code: Unable to access opcode bytes at 0x7ff06dbdbe73.
[   27.963661] [ T2553] RSP: 002b:00007ffde44f9ac8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
[   27.963664] [ T2553] RAX: ffffffffffffffda RBX: 00007ff06dce4fa8 RCX: 00007ff06dbdbe9d
[   27.963665] [ T2553] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
[   27.963666] [ T2553] RBP: 0000000000000000 R08: 00007ffde44f9a70 R09: 00007ffde44f99ff
[   27.963667] [ T2553] R10: 00007ffde44f9980 R11: 0000000000000206 R12: 00007ff06dce3680
[   27.963668] [ T2553] R13: 00007ff06dd010e0 R14: 0000000000000002 R15: 00007ff06dce4fc0
[   27.963670] [ T2553]  </TASK>
[   27.963671] [ T2553] ---[ end trace 0000000000000000 ]---

Later on bigger problems start to appear:

[   69.035059] [ T2593] BUG: Bad page map in process ls  pte:10006c125 pmd:1003dc067
[   69.035061] [ T2593] page: refcount:8 mapcount:20 mapping:ffff88813fd736a8 index:0x110 pfn:0x10006c
[   69.035064] [ T2593] head: order:2 mapcount:-2 entire_mapcount:0 nr_pages_mapped:8388532 pincount:0
[   69.035066] [ T2593] memcg:ffff888003573000
[   69.035067] [ T2593] aops:0xffffffff8226fd20 ino:82467c dentry name(?):"libc.so.6"
[   69.035069] [ T2593] flags: 0x2000000000416c(referenced|uptodate|lru|active|private|head|node=0|zone=2)
[   69.035072] [ T2593] raw: 002000000000416c ffffea0004002348 ffffea0004001d08 ffff88813fd736a8
[   69.035074] [ T2593] raw: 0000000000000110 ffff888100d19860 0000000800000013 ffff888003573000
[   69.035076] [ T2593] head: 002000000000416c ffffea0004002348 ffffea0004001d08 ffff88813fd736a8
[   69.035078] [ T2593] head: 0000000000000110 ffff888100d19860 0000000800000013 ffff888003573000
[   69.035079] [ T2593] head: 0020000000000202 ffffea0004001b01 ffffffb4fffffffd 00000000ffffffff
[   69.035081] [ T2593] head: 0000000300000003 0000000500000002 0000000000000013 0000000000000004
[   69.035082] [ T2593] page dumped because: bad pte
[   69.035083] [ T2593] addr:00007f6524b96000 vm_flags:00000075 anon_vma:0000000000000000 mapping:ffff88813fd736a8 index:110
[   69.035086] [ T2593] file:libc.so.6 fault:xfs_filemap_fault mmap:xfs_file_mmap read_folio:xfs_vm_read_folio

The system eventually becomes unusable and typically crashes.

I was able to bisect this issue to the commit: 10ebac4f95e7 ("mm/memory:
optimize unmap/zap with PTE-mapped THP").

If I understand correctly, the folio from the first warning has 4 pages,
but folio_pte_batch incorrectly counts 5 pages, because expected_pte and
pte are both zero-valued PTEs, and the loop is not broken in such a case
because pte_same() returns true.

[   27.963266] [ T2553] folio_pte_batch debug: printing PTE values starting at addr=0x7ff06dc11000
[   27.963268] [ T2553]   PTE[ 0] = 000000010085c125
[   27.963272] [ T2553]   PTE[ 1] = 000000010085d125
[   27.963274] [ T2553]   PTE[ 2] = 000000010085e125
[   27.963276] [ T2553]   PTE[ 3] = 000000010085f125
[   27.963277] [ T2553]   PTE[ 4] = 0000000000000000 <-- not present
[   27.963279] [ T2553]   PTE[ 5] = 0000000102e47125
[   27.963281] [ T2553]   PTE[ 6] = 0000000102e48125
[   27.963283] [ T2553]   PTE[ 7] = 0000000102e49125

As a consequence, zap_present_folio_ptes() is called with nr = 5, which
later calls folio_remove_rmap_ptes(), where __folio_rmap_sanity_checks()
emits the warning log.

The patch in the following message fixes the problem for me. It adds a
check that breaks the loop when encountering non-present PTE, before the
!pte_same() check.

I still don't fully understand how the zero-valued PTE appears there or
why this issue is triggered only when xen-balloon driver shrinks the
memory. I wasn't able to reproduce it without shrinking.

Cheers,
Petr

Petr Vaněk (1):
  mm: Fix folio_pte_batch() overcount with zero PTEs

 mm/internal.h | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.48.1


