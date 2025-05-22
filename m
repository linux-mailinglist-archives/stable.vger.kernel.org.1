Return-Path: <stable+bounces-146142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA36AC18DA
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 02:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9772E505376
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAB0137E;
	Fri, 23 May 2025 00:05:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD419A;
	Fri, 23 May 2025 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958740; cv=none; b=PBeTV1ehs/Unx79Z/t/QWrkVKzBJayIF+lrli7tTP/bv1DEIGKfsYWoZ3Jx91fabed7yuvNF5XF0r+FxBYHF2zcj2u+Y15znLpjFRMlfwdGVkE3IKwwdoxGkzGmirWaBH3VFnYPwttJDfCE4mDQhcs9K7DFEQteChYEkrK2yplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958740; c=relaxed/simple;
	bh=FKJEwrRMLguey2BvAvV40YEjlFi9E5GX6RFzd6ghb0I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XSwCzJhcO4iD2HzSTUS/5AOMPinvwfIwVrSCUW+27K8EHR8KK3UgYF5+JeXQ1sKMaH1IBwFOzZqVHUB7yqG8B/Yw91jv/0P6HfG/d/zv3EChNIuQaaRyaWRt2R5oWWaB4R2MOXEd5Sfw7DbDnyC9ZW/vE0s9UjLolVIdnL30WNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uIFDv-008Vm2-4u;
	Thu, 22 May 2025 23:21:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Haixiao Yan" <haixiao.yan.cn@windriver.com>
Cc:
 chuck.lever@oracle.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: nfs mount failed with ipv6 addr
In-reply-to: <faf777ea-3667-45c7-b7f2-111b9f789e73@windriver.com>
References: <>, <faf777ea-3667-45c7-b7f2-111b9f789e73@windriver.com>
Date: Fri, 23 May 2025 09:21:14 +1000
Message-id: <174795607490.608730.5673295992775861610@noble.neil.brown.name>

On Thu, 22 May 2025, Haixiao Yan wrote:
> On 2025/5/22 07:32, NeilBrown wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.
> >
> > On Thu, 22 May 2025, Yan, Haixiao (CN) wrote:
> >> On linux-5.10.y, my testcase run failed:
> >>
> >> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount -=
t nfs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3D3
> >> mount.nfs: requested NFS version or transport protocol is not supported
> >>
> >> The first bad commit is:
> >>
> >> commit 7229200f68662660bb4d55f19247eaf3c79a4217
> >> Author: Chuck Lever <chuck.lever@oracle.com>
> >> Date:   Mon Jun 3 10:35:02 2024 -0400
> >>
> >>     nfsd: don't allow nfsd threads to be signalled.
> >>
> >>     [ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]
> >>
> >>
> >> Here is the test log:
> >>
> >> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# dd if=
=3D/dev/zero of=3D/tmp/nfs.img bs=3D1M count=3D100
> >> 100+0 records in
> >> 100+0 records out
> >> 104857600 bytes (105 MB, 100 MiB) copied, 0.0386658 s, 2.7 GB/s
> >> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkfs /t=
mp/nfs.img
> >> mke2fs 1.46.1 (9-Feb-2021)
> >> Discarding device blocks:   1024/102400=08=08=08=08=08=08=08=08=08=08=08=
=08=08             =08=08=08=08=08=08=08=08=08=08=08=08=08done
> >> Creating filesystem with 102400 1k blocks and 25688 inodes
> >> Filesystem UUID: 77e3bc56-46bb-4e5c-9619-d9a0c0999958
> >> Superblock backups stored on blocks:
> >>        8193, 24577, 40961, 57345, 73729
> >>
> >> Allocating group tables:  0/13=08=08=08=08=08     =08=08=08=08=08done
> >> Writing inode tables:  0/13=08=08=08=08=08     =08=08=08=08=08done
> >> Writing superblocks and filesystem accounting information:  0/13=08=08=
=08=08=08     =08=08=08=08=08done
> >> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount /=
tmp/nfs.img /mnt
> >>
> >> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkdir /=
mnt/nfs_root
> >>
> >> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# touch /=
etc/exports
> >>
> >> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# echo '/=
mnt/nfs_root *(insecure,rw,async,no_root_squash)' >> /etc/exports
> >>
> >> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# /opt/wr=
-test/bin/svcwp.sh nfsserver restart
> >> stopping mountd: done
> >> stopping nfsd: ..........failed
> >>    using signal 9:
> >> ..........failed
> > What does your "nfsserver" script do to try to stop/restart the nfsd?
> > For a very long time the approved way to stop nfsd has been to run
> > "rpc.nfsd 0".  My guess is that whatever script you are using still
> > trying to send a signal to nfsd.  That no longer works.
> >
> > Unfortunately the various sysv-init scripts for starting/stopping nfsd
> > have never been part of nfs-utils so we were not able to update them.
> > nfs-utils *does* contain systemd unit files for sites which use systemd.
> >
> > If you have a non-systemd way of starting/stopping nfsd, we would be
> > happy to make the relevant scripts part of nfs-utils so that we can
> > ensure they stay up to date.
>=20
> Actually, we use=C2=A0 service nfsserver restart=C2=A0 =3D>
> /etc/init.d/nfsserver =3D>
>=20
> stop_nfsd(){
>  =C2=A0=C2=A0 =C2=A0# WARNING: this kills any process with the executable
>  =C2=A0=C2=A0 =C2=A0# name 'nfsd'.
>  =C2=A0=C2=A0 =C2=A0echo -n 'stopping nfsd: '
>  =C2=A0=C2=A0 =C2=A0start-stop-daemon --stop --quiet --signal 1 --name nfsd
>  =C2=A0=C2=A0 =C2=A0if delay_nfsd || {
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 echo failed
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 echo ' using signal 9: '
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 start-stop-daemon --stop --quiet --s=
ignal 9 --name nfsd
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 delay_nfsd
>  =C2=A0=C2=A0 =C2=A0}
>  =C2=A0=C2=A0 =C2=A0then
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 echo done
>  =C2=A0=C2=A0 =C2=A0else
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 echo failed
>  =C2=A0=C2=A0 =C2=A0fi
The above should all be changed to
   echo -n 'stopping nfsd: '
   rpc.nfsd 0
   echo done

or similar.  What distro are you using?

I can't see how this would affect your problem with IPv6 but it would be
nice if you could confirm that IPv6 still doesn't work even after
changing the above.
What version of nfs-utils are you using?
Are you should that the kernel has IPv6 enabled?  Does "ping6 ::1" work?

NeilBrown


> }
>=20
> Thanks,
>=20
> Haixiao
>=20
> > Thanks,
> > NeilBrown
>=20


