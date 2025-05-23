Return-Path: <stable+bounces-146195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BBAAC226B
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 14:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA3116D7AF
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500122356B2;
	Fri, 23 May 2025 12:13:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BE1DD889;
	Fri, 23 May 2025 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002419; cv=none; b=KggU96DG0sNwZf+dkIlUndo32gwDS3TO800/uwb6TYr4Gg2JecPg1O8AliP5eyBjB1xZc62MHbMAMcBdyl0jSBJxON8cZS0ikQDqlQX3thUb5H+6RqKGHRW1qHsomJR6Ey8ZWtFlC8ncVyxc9U0ww7pEnXfFdm5ubt6qYy1ncUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002419; c=relaxed/simple;
	bh=/7wwR4AGgKL5RHJnoGFvxZQNG16hhUNgZ0lkhkolwkw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Tx8tBTkPDPwGbhLlM/x2fkjfvCFY9NVXOnCYClruZWzUm+mbTtVoRq5GMMBfDzPHlga5SEhRyo3OxSIdTlIBpg/JsTRIQQzOg0h7hqsqz8pJjIWgJYvgfQKRIJnrGiIDZSHORD+uH4Hs0bG/uIyPVP6uJPtSqrw3KXdEgIdZucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uIRHI-0095Z2-LV;
	Fri, 23 May 2025 12:13:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
Cc:
 chuck.lever@oracle.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: nfs mount failed with ipv6 addr
In-reply-to: <ba4f9f5d-0688-4537-b721-7b2bda8ead8c@windriver.com>
References: <>, <ba4f9f5d-0688-4537-b721-7b2bda8ead8c@windriver.com>
Date: Fri, 23 May 2025 22:13:32 +1000
Message-id: <174800241235.608730.3027057856480430075@noble.neil.brown.name>

On Fri, 23 May 2025, Yan, Haixiao (CN) wrote:
> On 5/23/2025 3:42 PM, NeilBrown wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.
> >
> > On Fri, 23 May 2025, Yan, Haixiao (CN) wrote:
> >> On 5/23/2025 7:21 AM, NeilBrown wrote:
> >>> CAUTION: This email comes from a non Wind River email account!
> >>> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >>>
> >>> On Thu, 22 May 2025, Haixiao Yan wrote:
> >>>> On 2025/5/22 07:32, NeilBrown wrote:
> >>>>> CAUTION: This email comes from a non Wind River email account!
> >>>>> Do not click links or open attachments unless you recognize the sende=
r and know the content is safe.
> >>>>>
> >>>>> On Thu, 22 May 2025, Yan, Haixiao (CN) wrote:
> >>>>>> On linux-5.10.y, my testcase run failed:
> >>>>>>
> >>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mou=
nt -t nfs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3D3
> >>>>>> mount.nfs: requested NFS version or transport protocol is not suppor=
ted
> >>>>>>
> >>>>>> The first bad commit is:
> >>>>>>
> >>>>>> commit 7229200f68662660bb4d55f19247eaf3c79a4217
> >>>>>> Author: Chuck Lever <chuck.lever@oracle.com>
> >>>>>> Date:   Mon Jun 3 10:35:02 2024 -0400
> >>>>>>
> >>>>>>       nfsd: don't allow nfsd threads to be signalled.
> >>>>>>
> >>>>>>       [ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]
> >>>>>>
> >>>>>>
> >>>>>> Here is the test log:
> >>>>>>
> >>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# dd =
if=3D/dev/zero of=3D/tmp/nfs.img bs=3D1M count=3D100
> >>>>>> 100+0 records in
> >>>>>> 100+0 records out
> >>>>>> 104857600 bytes (105 MB, 100 MiB) copied, 0.0386658 s, 2.7 GB/s
> >>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkf=
s /tmp/nfs.img
> >>>>>> mke2fs 1.46.1 (9-Feb-2021)
> >>>>>> Discarding device blocks:   1024/102400=08=08=08=08=08=08=08=08=08=
=08=08=08=08             =08=08=08=08=08=08=08=08=08=08=08=08=08done
> >>>>>> Creating filesystem with 102400 1k blocks and 25688 inodes
> >>>>>> Filesystem UUID: 77e3bc56-46bb-4e5c-9619-d9a0c0999958
> >>>>>> Superblock backups stored on blocks:
> >>>>>>          8193, 24577, 40961, 57345, 73729
> >>>>>>
> >>>>>> Allocating group tables:  0/13=08=08=08=08=08     =08=08=08=08=08done
> >>>>>> Writing inode tables:  0/13=08=08=08=08=08     =08=08=08=08=08done
> >>>>>> Writing superblocks and filesystem accounting information:  0/13=08=
=08=08=08=08     =08=08=08=08=08done
> >>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mou=
nt /tmp/nfs.img /mnt
> >>>>>>
> >>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkd=
ir /mnt/nfs_root
> >>>>>>
> >>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# tou=
ch /etc/exports
> >>>>>>
> >>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# ech=
o '/mnt/nfs_root *(insecure,rw,async,no_root_squash)' >> /etc/exports
> >>>>>>
> >>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# /op=
t/wr-test/bin/svcwp.sh nfsserver restart
> >>>>>> stopping mountd: done
> >>>>>> stopping nfsd: ..........failed
> >>>>>>      using signal 9:
> >>>>>> ..........failed
> >>>>> What does your "nfsserver" script do to try to stop/restart the nfsd?
> >>>>> For a very long time the approved way to stop nfsd has been to run
> >>>>> "rpc.nfsd 0".  My guess is that whatever script you are using still
> >>>>> trying to send a signal to nfsd.  That no longer works.
> >>>>>
> >>>>> Unfortunately the various sysv-init scripts for starting/stopping nfsd
> >>>>> have never been part of nfs-utils so we were not able to update them.
> >>>>> nfs-utils *does* contain systemd unit files for sites which use syste=
md.
> >>>>>
> >>>>> If you have a non-systemd way of starting/stopping nfsd, we would be
> >>>>> happy to make the relevant scripts part of nfs-utils so that we can
> >>>>> ensure they stay up to date.
> >>>> Actually, we use  service nfsserver restart  =3D>
> >>>> /etc/init.d/nfsserver =3D>
> >>>>
> >>>> stop_nfsd(){
> >>>>        # WARNING: this kills any process with the executable
> >>>>        # name 'nfsd'.
> >>>>        echo -n 'stopping nfsd: '
> >>>>        start-stop-daemon --stop --quiet --signal 1 --name nfsd
> >>>>        if delay_nfsd || {
> >>>>            echo failed
> >>>>            echo ' using signal 9: '
> >>>>            start-stop-daemon --stop --quiet --signal 9 --name nfsd
> >>>>            delay_nfsd
> >>>>        }
> >>>>        then
> >>>>            echo done
> >>>>        else
> >>>>            echo failed
> >>>>        fi
> >>> The above should all be changed to
> >>>      echo -n 'stopping nfsd: '
> >>>      rpc.nfsd 0
> >>>      echo done
> >>>
> >>> or similar.  What distro are you using?
> >>>
> >>> I can't see how this would affect your problem with IPv6 but it would be
> >>> nice if you could confirm that IPv6 still doesn't work even after
> >>> changing the above.
> >>> What version of nfs-utils are you using?
> >>> Are you should that the kernel has IPv6 enabled?  Does "ping6 ::1" work?
> >>>
> >>> NeilBrown
> >>>
> >> It works as expected.
> >>
> >> My distro is Yocto and nfs-utils 2.5.3.
> > Thanks.  I've sent a patch to openembedded to change the nfsserver
> > script.
> >
> > Can you make the change to nfsserver and let me know if it fixes your
> > problem?
>=20
> What's the version of your nfs-utils?

The patch isn't against nfs-utils.  It is against openembedded-core
   https://git.openembedded.org/openembedded-core
which is what yocto is based on.

I was expecting you to manually edit /etc/init.d/nfsserver to make the
changes.
Or you could possibly:

  patch /etc/init.d/nfssever < THE-PATCH

NeilBrown


>=20
> The patch failed to apply.
>=20
> $ git am '[PATCH OE-core] nfs-utils don'\''t use signals to shut down=20
> nfs server. - '\''NeilBrown '\'' (neil@brown.name) - 2025-05-23=20
> 1541.eml' Applying: nfs-utils: don't use signals to shut down nfs=20
> server. error: patch failed:=20
> meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver:89 error:=20
> meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver: patch does not=20
> apply Patch failed at 0001 nfs-utils: don't use signals to shut down nfs=20
> server. hint: Use 'git am --show-current-patch=3Ddiff' to see the failed=20
> patch When you have resolved this problem, run "git am --continue". If=20
> you prefer to skip this patch, run "git am --skip" instead. To restore=20
> the original branch and stop patching, run "git am --abort".
>=20
> Thanks,
>=20
> Haixiao
>=20
> >
> > Thanks,
> > NeilBrown
>=20


