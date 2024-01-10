Return-Path: <stable+bounces-9948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E86825F48
	for <lists+stable@lfdr.de>; Sat,  6 Jan 2024 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D27F6B22A8D
	for <lists+stable@lfdr.de>; Sat,  6 Jan 2024 10:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004696AA3;
	Sat,  6 Jan 2024 10:41:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16E6FA1;
	Sat,  6 Jan 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rM46v-0006Mp-Kr; Sat, 06 Jan 2024 11:41:01 +0100
Message-ID: <8e59220d-b0f3-4dae-afc3-36acfa6873e4@leemhuis.info>
Date: Sat, 6 Jan 2024 11:40:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression 6.1.y] From "cifs: Fix flushing, invalidation and
 file size with copy_file_range()"
Content-Language: en-US, de-DE
To: Salvatore Bonaccorso <carnil@debian.org>,
 "Jitindar Singh, Suraj" <surajjs@amazon.com>
Cc: "rohiths.msft@gmail.com" <rohiths.msft@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "stfrench@microsoft.com" <stfrench@microsoft.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "pc@manguebit.com" <pc@manguebit.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "nspmangalore@gmail.com" <nspmangalore@gmail.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
 stable@vger.kernel.org, linux-cifs@vger.kernel.org,
 regressions@lists.linux.dev
References: <2023121124-trifle-uncharted-2622@gregkh>
 <a76b370f93cb928c049b94e1fde0d2da506dfcb2.camel@amazon.com>
 <ZZhrpNJ3zxMR8wcU@eldamar.lan>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZZhrpNJ3zxMR8wcU@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1704537682;0ab4f152;
X-HE-SMSGID: 1rM46v-0006Mp-Kr

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Thank's for CCIng the regression list and telling regzbot about the
issue. There is one important thing that afaics[1] is missing and would
be really good to know[2]:

Does this problem also happen in mainline, e.g. with 6.7-rc8?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] I hope I didn't miss this
[2] as explained here:
https://docs.kernel.org/admin-guide/reporting-issues.html
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-k=
ernel-bug-reports-are-ignored/#you-reported-a-regression-in-a-stable-or-l=
ongterm-series-without-checking-if-mainline-is-affected-as-well

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

On 05.01.24 21:50, Salvatore Bonaccorso wrote:
>=20
> Looping in as well regressions@lists.linux.dev list (and add
> linux-cifs@vger.kernel.org as well here).
>=20
> On Wed, Jan 03, 2024 at 11:40:04PM +0000, Jitindar Singh, Suraj wrote:
>> Hi,
>>
>> When testing the v6.1.69 kernel I bisected an issue to the below commi=
t
>> which was added in v6.1.68. When running the xfstests[1] on cifs I
>> observe a null pointer dereference in cifs_flush_folio() because folio=

>> is null and dereferenced in size =3D folio_size(folio).
>>
>> [1] https://github.com/kdave/xfstests
>>
>> This can be reproduced using many of the xfstests but reproduces with
>> generic/001 like below:
>>
>> $ ./check -cifs generic/001
>>
>> FSTYP         -- cifs
>> PLATFORM      -- Linux/x86_64 ip-172-31-36-150 6.1.69 #2 SMP
>> PREEMPT_DYNAMIC Wed Jan  3 22:36:43 UTC 2024
>> MKFS_OPTIONS  -- //172.31.34.66/scratch
>> MOUNT_OPTIONS -- -ousername=3Dec2-
>> user,password=3Dabc123,noperm,mfsymlinks,cifsacl,actimeo=3D0 -o
>> context=3Dsystem_u:object_r:root_t:s0 //172.31.34.66/scratch /mnt/scra=
tch
>>
>> generic/001 10s ... =20
>>
>> [  244.135555] run fstests generic/001 at 2024-01-03 22:44:59
>> [  244.637499] BUG: kernel NULL pointer dereference, address:
>> 0000000000000000
>> [  244.638204] #PF: supervisor read access in kernel mode
>> [  244.638698] #PF: error_code(0x0000) - not-present page
>> [  244.639194] PGD 0 P4D 0=20
>> [  244.639466] Oops: 0000 [#1] PREEMPT SMP NOPTI
>> [  244.698047] CPU: 11 PID: 4123 Comm: cp Not tainted 6.1.69 #2
>> [  244.698598] Hardware name: Amazon EC2 m6i.4xlarge/, BIOS 1.0
>> 10/16/2017
>> [  244.699228] RIP: 0010:cifs_flush_folio+0x3f/0x100 [cifs]
>> [  244.699782] Code: d2 41 54 89 cc 31 c9 55 53 48 89 f3 48 c1 ee 0c 4=
8
>> 83 ec 08 48 8b 7f 30 e8 7d 2c a6 f8 48 3d 00 f0 ff ff 0f 87 a5 00 00 0=
0
>> <48> 8b 10 48 89 c5 b8 00 10 00 00 f7 c2 00 00 01 00 74 07 0f b6 4d
>> [  244.799263] RSP: 0018:ffffc25441ffbd20 EFLAGS: 00010207
>> [  244.888911] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [  244.898446] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>> ffff9ed945eac000
>> [  244.899136] RBP: 00000000000003a1 R08: 0000000000000001 R09:
>> 0000000000000000
>> [  244.997779] R10: 0000000000003e7f R11: 0000000000000000 R12:
>> ffffc25441ffbd90
>> [  244.998564] R13: ffffc25441ffbd88 R14: ffff9ed94af23850 R15:
>> 0000000000000001
>> [  244.999264] FS:  00007f111404d340(0000) GS:ffff9ee7fecc0000(0000)
>> knlGS:0000000000000000
>> [  245.097782] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  245.098345] CR2: 0000000000000000 CR3: 00000001211fc001 CR4:
>> 00000000007706e0
>> [  245.099122] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [  245.099854] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [  245.198200] PKRU: 55555554
>> [  245.198478] Call Trace:
>> [  245.198735]  <TASK>
>> [  245.198967]  ? show_trace_log_lvl+0x1c4/0x2d2
>> [  245.199399]  ? show_trace_log_lvl+0x1c4/0x2d2
>> [  245.199830]  ? cifs_remap_file_range+0x15d/0x5e0 [cifs]
>> [  245.298029]  ? __die_body.cold+0x8/0xd
>> [  245.298402]  ? page_fault_oops+0xac/0x140
>> [  245.298943]  ? exc_page_fault+0x62/0x140
>> [  245.299336]  ? asm_exc_page_fault+0x22/0x30
>> [  245.299751]  ? cifs_flush_folio+0x3f/0x100 [cifs]
>> [  245.397858]  ? cifs_precopy_set_eof+0x73/0x110 [cifs]
>> [  245.398383]  cifs_remap_file_range+0x15d/0x5e0 [cifs]
>> [  245.398909]  do_clone_file_range+0xe7/0x230
>> [  245.399329]  vfs_clone_file_range+0x37/0x140
>> [  245.399861]  ioctl_file_clone+0x45/0xa0
>> [  245.497918]  do_vfs_ioctl+0x79/0x890
>> [  245.498328]  __x64_sys_ioctl+0x69/0xc0
>> [  245.498706]  do_syscall_64+0x38/0x90
>> [  245.499070]  entry_SYSCALL_64_after_hwframe+0x64/0xce
>> [  245.499568] RIP: 0033:0x7f1113e3ec6b
>> [  245.499929] Code: 73 01 c3 48 8b 0d 9500 f7 d8 64 89 01 48 83 c8 ff=

>> c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05
>> <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 65 a1 1b 00 f7 d8 64 89 01 48
>> [  245.599410] RSP: 002b:00007fff140ebb88 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000010
>> [  245.697930] RAX: ffffffffffffffda RBX: 00007fff140ec3b0 RCX:
>> 00007f1113e3ec6b
>> [  245.698620] RDX: 0000000000000003 RSI: 0000000040049409 RDI:
>> 0000000000000004
>> [  245.699306] RBP: 0000000000000003 R08: 0000000000000001 R09:
>> 0000000000000004
>> [  245.797942] R10: 0000000000001000 R11: 0000000000000246 R12:
>> 00007fff140ed616
>> [  245.798789] R13: 00007fff140ebfa0 R14: 0000000000000000 R15:
>> 0000000000000002
>> [  245.799485]  </TASK>
>> [  245.799720] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md=
4
>> dns_lver mousedev sunrpc nls_ascii nls_cp437 vfat fat psmouse
>> ghash_clmulni_intel atkbd libps2 vivaldi_fmap aesni_intel ena i8042
>> crypto_simd serio cryptd button drm sch_fq_codel fuse i2c_core configf=
s
>> drm_panel_orientation_quirks loop backlight dmi_sysfs crc32_pclmul
>> intel dm_mirror dm_region_hash dm_log dm_mod dax efivarfs
>> [  245.998457] CR2: 0000000000000000
>> [  245.998800] ---[ end trace 0000000000000000 ]---
>> [  246.087916] RIP: 0010:cifs_flush_folio+0x3f/0x100 [cifs]
>> [  246.088794] Code: d2 41 54 49 89 cc 31 c9 55 53 48 89 f3 48 c1 ee 0=
c
>> 48 83 ec 08 48 8b 7f 30 e8 7d 2c a6 f8 48 3d 00 f0 ff ff 0f 87 a5 00 0=
0
>> 00 <48> 8b 10 48 89 c5 b8 00 10 00 00 f7 c2 00 00 01 00 74 07 0f b6 4d=

>> [  246.099436] RSP: 0018:ffffc25441ffbd20 EFLAGS: 00010207
>> [  246.189258] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [  246.198724] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>> ffff9ed945eac000
>> [  246.199411] RBP: 00000000000003a1 R08: 0000000000000001 R09:
>> 0000000000000000
>> [  246.298002] R10: 0000000000003e7f R11: 0000000000000000 R12:
>> ffffc25441ffbd90
>> [  246.298687] R13: ffffc25441ffbd88 R14: ffff9ed94af23850 R15:
>> 0000000000000001
>> [  246.299372] FS:  00007f111404d340(0000) GS:ffff9ee7fecc0000(0000)
>> knlGS:0000000000000000
>> [  246.398006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  246.398569] CR2: 0000000000000000 CR3: 00000001211fc001 CR4:
>> 00000000007706e0
>> [  246.399254] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [  246.399934] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [  246.498414] PKRU: 55555554
>> [  246.498698] Kernel panic - not syncing: Fatal exception
>> [  246.500042] Kernel Offset: 0x38000000 from 0xffffffff81000000
>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [  246.698094] Rebooting in 5 seconds..
>>
>> Any ideas what is causing this and what the resolution is? This doesn'=
t
>> occur on the upstream/master kernel.
>>
>> Thanks,
>> Suraj
>>
>> On Mon, 2023-12-11 at 13:57 +0100, gregkh@linuxfoundation.org wrote:
>>>
>>> This is a note to let you know that I've just added the patch titled
>>>
>>> =C2=A0=C2=A0=C2=A0 cifs: Fix flushing, invalidation and file size wit=
h
>>> copy_file_range()
>>>
>>> to the 6.1-stable tree which can be found at:
>>> =C2=A0=C2=A0=C2=A0
>>> http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>>>
>>> The filename of the patch is:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 cifs-fix-flushing-invalidation-and-file-size=
-with-
>>> copy_file_range.patch
>>> and it can be found in the queue-6.1 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable
>>> tree,
>>> please let <stable@vger.kernel.org> know about it.
>>>
>>>
>>>> From 7b2404a886f8b91250c31855d287e632123e1746 Mon Sep 17 00:00:00
>>>> 2001
>>> From: David Howells <dhowells@redhat.com>
>>> Date: Fri, 1 Dec 2023 00:22:00 +0000
>>> Subject: cifs: Fix flushing, invalidation and file size with
>>> copy_file_range()
>>>
>>> From: David Howells <dhowells@redhat.com>
>>>
>>> commit 7b2404a886f8b91250c31855d287e632123e1746 upstream.
>>>
>>> Fix a number of issues in the cifs filesystem implementation of the
>>> copy_file_range() syscall in cifs_file_copychunk_range().
>>>
>>> Firstly, the invalidation of the destination range is handled
>>> incorrectly:
>>> We shouldn't just invalidate the whole file as dirty data in the file=

>>> may
>>> get lost and we can't just call truncate_inode_pages_range() to
>>> invalidate
>>> the destination range as that will erase parts of a partial folio at
>>> each
>>> end whilst invalidating and discarding all the folios in the middle.=C2=
=A0
>>> We
>>> need to force all the folios covering the range to be reloaded, but
>>> we
>>> mustn't lose dirty data in them that's not in the destination range.
>>>
>>> Further, we shouldn't simply round out the range to PAGE_SIZE at each=

>>> end
>>> as cifs should move to support multipage folios.
>>>
>>> Secondly, there's an issue whereby a write may have extended the file=

>>> locally, but not have been written back yet.=C2=A0 This can leaves th=
e
>>> local
>>> idea of the EOF at a later point than the server's EOF.=C2=A0 If a co=
py
>>> request
>>> is issued, this will fail on the server with STATUS_INVALID_VIEW_SIZE=

>>> (which gets translated to -EIO locally) if the copy source extends
>>> past the
>>> server's EOF.
>>>
>>> Fix this by:
>>>
>>> =C2=A0(0) Flush the source region (already done).=C2=A0 The flush doe=
s nothing
>>> and
>>> =C2=A0=C2=A0=C2=A0=C2=A0 the EOF isn't moved if the source region has=
 no dirty data.
>>>
>>> =C2=A0(1) Move the EOF to the end of the source region if it isn't al=
ready
>>> at
>>> =C2=A0=C2=A0=C2=A0=C2=A0 least at this point.=C2=A0 If we can't do th=
is, for instance if the
>>> server
>>> =C2=A0=C2=A0=C2=A0=C2=A0 doesn't support it, just flush the entire so=
urce file.
>>>
>>> =C2=A0(2) Find the folio (if present) at each end of the range, flush=
ing
>>> it and
>>> =C2=A0=C2=A0=C2=A0=C2=A0 increasing the region-to-be-invalidated to c=
over those in their
>>> =C2=A0=C2=A0=C2=A0=C2=A0 entirety.
>>>
>>> =C2=A0(3) Fully discard all the folios covering the range as we want =
them
>>> to be
>>> =C2=A0=C2=A0=C2=A0=C2=A0 reloaded.
>>>
>>> =C2=A0(4) Then perform the copy.
>>>
>>> Thirdly, set i_size after doing the copychunk_range operation as this=

>>> value
>>> may be used by various things internally.=C2=A0 stat() hides the issu=
e
>>> because
>>> setting ->time to 0 causes cifs_getatr() to revalidate the
>>> attributes.
>>>
>>> These were causing the generic/075 xfstest to fail.
>>>
>>> Fixes: 620d8745b35d ("Introduce cifs_copy_file_range()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>> cc: Paulo Alcantara <pc@manguebit.com>
>>> cc: Shyam Prasad N <nspmangalore@gmail.com>
>>> cc: Rohith Surabattula <rohiths.msft@gmail.com>
>>> cc: Matthew Wilcox <willy@infradead.org>
>>> cc: Jeff Layton <jlayton@kernel.org>
>>> cc: linux-cifs@vger.kernel.org
>>> cc: linux-mm@kvack.org
>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>> Signed-off-by: Steve French <stfrench@microsoft.com>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>> =C2=A0fs/smb/client/cifsfs.c |=C2=A0 102
>>> +++++++++++++++++++++++++++++++++++++++++++++++--
>>> =C2=A01 file changed, 99 insertions(+), 3 deletions(-)
>>>
>>> --- a/fs/smb/client/cifsfs.c
>>> +++ b/fs/smb/client/cifsfs.c
>>> @@ -1191,6 +1191,72 @@ const struct inode_operations cifs_symli
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.listxattr =3D cifs_l=
istxattr,
>>> =C2=A0};
>>> =C2=A0
>>> +/*
>>> + * Advance the EOF marker to after the source range.
>>> + */
>>> +static int cifs_precopy_set_eof(struct inode *src_inode, struct
>>> cifsInodeInfo *src_cifsi,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cifs_tcon *src_tcon,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int xid, loff_t src_en=
d)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cifsFileInfo *write=
able_srcfile;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc =3D -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writeable_srcfile =3D find=
_writable_file(src_cifsi,
>>> FIND_WR_FSUID_ONLY);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (writeable_srcfile) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (src_tcon->ses->server->ops->set_file_size)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D=
 src_tcon->ses->server->ops-
>>>> set_file_size(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xid, src_tcon, writeable_srcfil=
e,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0src_inode->i_size, true /* no n=
eed to
>>> set sparse */);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D=
 -ENOSYS;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0cifsFileInfo_put(writeable_srcfile);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0cifs_dbg(FYI, "SetFSize for copychunk rc =3D %d\n",
>>> rc);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto set_failed;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netfs_resize_file(&src_cif=
si->netfs, src_end);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fscache_resize_cookie(cifs=
_inode_cookie(src_inode), src_end);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>>> +
>>> +set_failed:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return filemap_write_and_w=
ait(src_inode->i_mapping);
>>> +}
>>> +
>>> +/*
>>> + * Flush out either the folio that overlaps the beginning of a range=

>>> in which
>>> + * pos resides or the folio that overlaps the end of a range unless
>>> that folio
>>> + * is entirely within the range we're going to invalidate.=C2=A0 We
>>> extend the flush
>>> + * bounds to encompass the folio.
>>> + */
>>> +static int cifs_flush_folio(struct inode *inode, loff_t pos, loff_t
>>> *_fstart, loff_t *_fend,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bool first)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct folio *folio;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long long fpos, f=
end;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pgoff_t index =3D pos / PA=
GE_SIZE;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0folio =3D filemap_get_foli=
o(inode->i_mapping, index);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(folio))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size =3D folio_size(folio)=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fpos =3D folio_pos(folio);=

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fend =3D fpos + size - 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*_fstart =3D min_t(unsigne=
d long long, *_fstart, fpos);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*_fend=C2=A0=C2=A0 =3D max=
_t(unsigned long long, *_fend, fend);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((first && pos =3D=3D f=
pos) || (!first && pos =3D=3D fend))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto out;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D filemap_write_and_w=
ait_range(inode->i_mapping, fpos,
>>> fend);
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0folio_put(folio);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
>>> +}
>>> +
>>> =C2=A0static loff_t cifs_remap_file_range(struct file *src_file, loff=
_t
>>> off,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0struct file *dst_file, loff_t destoff, loff_t =
len,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int remap_flags)
>>> @@ -1260,10 +1326,12 @@ ssize_t cifs_file_copychunk_range(unsign
>>> =C2=A0{
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct inode *src_ino=
de =3D file_inode(src_file);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct inode *target_=
inode =3D file_inode(dst_file);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cifsInodeInfo *src_=
cifsi =3D CIFS_I(src_inode);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cifsFileInfo *=
smb_file_src;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cifsFileInfo *=
smb_file_target;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cifs_tcon *src=
_tcon;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cifs_tcon *tar=
get_tcon;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long long destend=
, fstart, fend;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t rc;
>>> =C2=A0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cifs_dbg(FYI, "copych=
unk range\n");
>>> @@ -1303,13 +1371,41 @@ ssize_t cifs_file_copychunk_range(unsign
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto unlock;
>>> =C2=A0
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* should we flush first a=
nd last page first */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0truncate_inode_pages(&targ=
et_inode->i_data, 0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The server-side copy wi=
ll fail if the source crosses the
>>> EOF marker.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Advance the EOF marker =
after the flush above to the end of
>>> the range
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if it's short of that.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (src_cifsi->server_eof =
< off + len) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rc =3D cifs_precopy_set_eof(src_inode, src_cifsi,
>>> src_tcon, xid, off + len);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (rc < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto=
 unlock;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0destend =3D destoff + len =
- 1;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Flush the folios at eit=
her end of the destination range to
>>> prevent
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * accidental loss of dirt=
y data outside of the range.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fstart =3D destoff;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fend =3D destend;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D cifs_flush_folio(ta=
rget_inode, destoff, &fstart, &fend,
>>> true);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto unlock;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D cifs_flush_folio(ta=
rget_inode, destend, &fstart, &fend,
>>> false);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto unlock;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Discard all the folios =
that overlap the destination
>>> region. */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0truncate_inode_pages_range=
(&target_inode->i_data, fstart,
>>> fend);
>>> =C2=A0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D file_modified(=
dst_file);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!rc)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!rc) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D target_tcon->ses->server->ops-
>>>> copychunk_range(xid,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
smb_file_src, smb_file_target, off, len,
>>> destoff);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (rc > 0 && destoff + rc >
>>> i_size_read(target_inode))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trun=
cate_setsize(target_inode, destoff + rc);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>> =C2=A0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0file_accessed(src_fil=
e);
>>> =C2=A0
>>>
>>>
>>> Patches currently in stable-queue which might be from
>>> dhowells@redhat.com=C2=A0are
>>>
>>> queue-6.1/cifs-fix-flushing-invalidation-and-file-size-with-
>>> copy_file_range.patch
>>> queue-6.1/cifs-fix-flushing-invalidation-and-file-size-with-
>>> ficlone.patch
>>> queue-6.1/cifs-fix-non-availability-of-dedup-breaking-generic-
>>> 304.patch
>>>
>>
>=20
> It looks we had as well some reports in Debian about this regression.
> Copying a file within the same cifs mount seems to trigger the NULL
> pointer dereference:
>=20
> [ 1640.742300] BUG: kernel NULL pointer dereference, address: 000000000=
0000000
> [ 1640.742309] #PF: supervisor read access in kernel mode
> [ 1640.742313] #PF: error_code(0x0000) - not-present page
> [ 1640.742317] PGD 0 P4D 0
> [ 1640.742322] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ 1640.742327] CPU: 6 PID: 1972 Comm: cp Not tainted 6.1.0-17-amd64 #1 =
 Debian 6.1.69-1
> [ 1640.742333] Hardware name: LENOVO 20XXS1FU00/20XXS1FU00, BIOS N32ET8=
9W (1.65 ) 11/13/2023
> [ 1640.742336] RIP: 0010:cifs_flush_folio+0x3f/0x100 [cifs]
> [ 1640.742412] Code: d2 41 54 49 89 cc 31 c9 55 48 89 f5 48 c1 ee 0c 53=
 48 83 ec 08 48 8b 7f 30 e8 8d 9a 97 dd 48 3d 00 f0 ff ff 0f 87 a5 00 00 =
00 <48> 8b 10 48 89 c3 b8 00 10 00 00 f7 c2 00 00 01 00 74 07 0f b6 4b
> [ 1640.742417] RSP: 0018:ffff9eac8181fd18 EFLAGS: 00010207
> [ 1640.742422] RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000=
000000000
> [ 1640.742425] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8a0=
a758b0000
> [ 1640.742428] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000=
000000000
> [ 1640.742431] R10: 0000000000000003 R11: ffff8a09c596fa00 R12: ffff9ea=
c8181fd88
> [ 1640.742433] R13: ffff9eac8181fd80 R14: ffff8a0a707bda48 R15: 0000000=
000000001
> [ 1640.742437] FS:  00007f7dc8764800(0000) GS:ffff8a10ff780000(0000) kn=
lGS:0000000000000000
> [ 1640.742441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1640.742444] CR2: 0000000000000000 CR3: 000000015eff0003 CR4: 0000000=
000770ee0
> [ 1640.742448] PKRU: 55555554
> [ 1640.742450] Call Trace:
> [ 1640.742454]  <TASK>
> [ 1640.742459]  ? __die_body.cold+0x1a/0x1f
> [ 1640.742468]  ? page_fault_oops+0xd2/0x2b0
> [ 1640.742476]  ? exc_page_fault+0x70/0x170
> [ 1640.742482]  ? asm_exc_page_fault+0x22/0x30
> [ 1640.742492]  ? cifs_flush_folio+0x3f/0x100 [cifs]
> [ 1640.742558]  ? cifs_flush_folio+0x33/0x100 [cifs]
> [ 1640.742622]  ? cifs_precopy_set_eof+0x2b/0x150 [cifs]
> [ 1640.742688]  cifs_remap_file_range+0x16d/0x680 [cifs]
> [ 1640.742755]  do_clone_file_range+0xe6/0x230
> [ 1640.742762]  vfs_clone_file_range+0x37/0x140
> [ 1640.742767]  ioctl_file_clone+0x49/0xb0
> [ 1640.742774]  do_vfs_ioctl+0x77/0x910
> [ 1640.742780]  __x64_sys_ioctl+0x6e/0xd0
> [ 1640.742785]  do_syscall_64+0x58/0xc0
> [ 1640.742794]  entry_SYSCALL_64_after_hwframe+0x64/0xce
> [ 1640.742801] RIP: 0033:0x7f7dc8900b5b
> [ 1640.742806] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10=
 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f =
05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 1640.742810] RSP: 002b:00007ffe4b899000 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
> [ 1640.742815] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f7=
dc8900b5b
> [ 1640.742817] RDX: 0000000000000003 RSI: 0000000040049409 RDI: 0000000=
000000004
> [ 1640.742820] RBP: 00007ffe4b899440 R08: 00007ffe4b899600 R09: 0000000=
000000001
> [ 1640.742823] R10: 00007f7dc881a358 R11: 0000000000000246 R12: 0000000=
000000001
> [ 1640.742825] R13: 00007ffe4b899dc3 R14: 0000000000008000 R15: 0000000=
000000000
> [ 1640.742831]  </TASK>
> [ 1640.742832] Modules linked in: nls_utf8 cifs cifs_arc4 cifs_md4 dns_=
resolver fscache netfs ctr ccm rfcomm cmac algif_hash algif_skcipher af_a=
lg snd_seq_dummy snd_hrtimer snd_seq snd_seq_device bnep btusb btrtl btbc=
m btintel btmtk bluetooth uvcvideo videobuf2_vmalloc videobuf2_memops jit=
terentropy_rng videobuf2_v4l2 videobuf2_common drbg videodev ansi_cprng m=
c ecdh_generic ecc qrtr ip6t_REJECT nf_reject_ipv6 xt_hl ip6_tables ip6t_=
rt snd_ctl_led snd_soc_skl_hda_dsp snd_soc_intel_hda_dsp_common binfmt_mi=
sc snd_soc_hdac_hdmi ipt_REJECT snd_sof_probes nf_reject_ipv4 xt_LOG nf_l=
og_syslog xt_comment nft_limit xt_limit xt_addrtype snd_hda_codec_hdmi sn=
d_hda_codec_realtek snd_hda_codec_generic snd_soc_dmic snd_sof_pci_intel_=
tgl snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation=
 joydev soundwire_cadence snd_sof_intel_hda x86_pkg_temp_thermal snd_sof_=
pci intel_powerclamp snd_sof_xtensa_dsp coretemp snd_sof snd_sof_utils sn=
d_soc_hdac_hda kvm_intel snd_hda_ext_core
> [ 1640.742921]  snd_soc_acpi_intel_match xt_tcpudp snd_soc_acpi kvm snd=
_soc_core xt_conntrack irqbypass nf_conntrack crc32_pclmul snd_compress n=
f_defrag_ipv6 soundwire_bus nf_defrag_ipv4 ghash_clmulni_intel iwlmvm nft=
_compat snd_hda_intel sha512_ssse3 snd_intel_dspcfg nf_tables snd_intel_s=
dw_acpi sha512_generic mac80211 libcrc32c snd_hda_codec hid_multitouch nf=
netlink processor_thermal_device_pci_legacy hid_generic sha256_ssse3 iTCO=
_wdt snd_hda_core processor_thermal_device sha1_ssse3 intel_pmc_bxt iTCO_=
vendor_support processor_thermal_rfim libarc4 pmt_telemetry rapl thinkpad=
_acpi snd_hwdep xhci_pci processor_thermal_mbox mei_hdcp watchdog intel_r=
apl_msr snd_pcm pmt_class nls_ascii nvram intel_cstate processor_thermal_=
rapl xhci_hcd ucsi_acpi iwlwifi platform_profile snd_timer nls_cp437 inte=
l_uncore i2c_hid_acpi intel_lpss_pci usbcore typec_ucsi ledtrig_audio thi=
nk_lmi mei_me i2c_i801 intel_rapl_common snd pcspkr vfat i2c_hid intel_lp=
ss roles cfg80211 firmware_attributes_class mei
> [ 1640.743007]  thunderbolt usb_common soundcore wmi_bmof fat int3403_t=
hermal idma64 i2c_smbus intel_vsec typec intel_soc_dts_iosf hid igen6_eda=
c button battery ac rfkill soc_button_array int340x_thermal_zone int3400_=
thermal intel_hid intel_pmc_core acpi_thermal_rel acpi_tad acpi_pad spars=
e_keymap msr parport_pc ppdev lp parport loop fuse efi_pstore configfs ef=
ivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic =
dm_crypt dm_mod i915 i2c_algo_bit drm_buddy nvme drm_display_helper nvme_=
core crc32c_intel t10_pi drm_kms_helper crc64_rocksoft cec crc64 rc_core =
crc_t10dif ttm crct10dif_generic aesni_intel crct10dif_pclmul psmouse drm=
 evdev crypto_simd cryptd crct10dif_common serio_raw video wmi
> [ 1640.743095] CR2: 0000000000000000
> [ 1640.743098] ---[ end trace 0000000000000000 ]---
> [ 1640.957607] RIP: 0010:cifs_flush_folio+0x3f/0x100 [cifs]
> [ 1640.957681] Code: d2 41 54 49 89 cc 31 c9 55 48 89 f5 48 c1 ee 0c 53=
 48 83 ec 08 48 8b 7f 30 e8 8d 9a 97 dd 48 3d 00 f0 ff ff 0f 87 a5 00 00 =
00 <48> 8b 10 48 89 c3 b8 00 10 00 00 f7 c2 00 00 01 00 74 07 0f b6 4b
> [ 1640.957683] RSP: 0018:ffff9eac8181fd18 EFLAGS: 00010207
> [ 1640.957685] RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000=
000000000
> [ 1640.957686] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8a0=
a758b0000
> [ 1640.957687] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000=
000000000
> [ 1640.957688] R10: 0000000000000003 R11: ffff8a09c596fa00 R12: ffff9ea=
c8181fd88
> [ 1640.957689] R13: ffff9eac8181fd80 R14: ffff8a0a707bda48 R15: 0000000=
000000001
> [ 1640.957691] FS:  00007f7dc8764800(0000) GS:ffff8a10ff780000(0000) kn=
lGS:0000000000000000
> [ 1640.957692] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1640.957693] CR2: 0000000000000000 CR3: 000000015eff0003 CR4: 0000000=
000770ee0
> [ 1640.957695] PKRU: 55555554
> [ 1640.957696] note: cp[1972] exited with irqs disabled
>=20
> #regzbot ^introduced 18b02e4343e8f5be6a2f44c7ad9899b385a92730
> #regzbot link: https://bugs.debian.org/1060005
> #regzbot link: https://bugs.debian.org/1060052
>=20
> Regards,
> Salvatore
>=20
>=20

