Return-Path: <stable+bounces-145946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F84AC00B4
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 01:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DD34A01AC
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 23:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9F6238C36;
	Wed, 21 May 2025 23:32:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA323716B;
	Wed, 21 May 2025 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870367; cv=none; b=mU1Q2qPmDRb4YTU5eYdoXTaCW9pDqlsnCVmCQ9iV9FR0Qy5ivFZqKDQUshNp1aqvW1rqMcDhszFBVu+oulDz7DZmyPXd8qRtziQBOdXdQAKZk4ADj2KnDPxUv8UcQCBCzALqIiyDnhGcK8Njh1xcQ9sail5acKYN+RNYHiP0obk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870367; c=relaxed/simple;
	bh=uCqvMDg1KiG4QopSJ9nmufRDSvCKfWNpPjdDCSGY+lQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TUTmdZ8cNkc5QJnrbc525wsd9Yjhd4rfLBREKgrpWQV07qaKoqcUjQL9pOPQI7syIcY4aJYOxa83rzsG+stZ1JXCmdJ9WEnHDgCVIFPturWGBH98/41hbo12JUZNbWqYygEAF6ed/EORK4AzGDi38HeVayQ3Q0t2Vm890bBH+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uHsvS-007kbc-9J;
	Wed, 21 May 2025 23:32:42 +0000
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
In-reply-to: <6bb8f01e-628d-4353-8ed5-f77939e99df9@windriver.com>
References: <6bb8f01e-628d-4353-8ed5-f77939e99df9@windriver.com>
Date: Thu, 22 May 2025 09:32:42 +1000
Message-id: <174787036205.62796.16633284882232555223@noble.neil.brown.name>

On Thu, 22 May 2025, Yan, Haixiao (CN) wrote:
> On linux-5.10.y, my testcase run failed:
>=20
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount -t n=
fs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3D3
> mount.nfs: requested NFS version or transport protocol is not supported
>=20
> The first bad commit is:
>=20
> commit 7229200f68662660bb4d55f19247eaf3c79a4217
> Author: Chuck Lever <chuck.lever@oracle.com>
> Date: =C2=A0 Mon Jun 3 10:35:02 2024 -0400
>=20
>  =C2=A0 nfsd: don't allow nfsd threads to be signalled.
>=20
>  =C2=A0 [ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]
>=20
>=20
> Here is the test log:
>=20
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# dd if=3D/d=
ev/zero of=3D/tmp/nfs.img bs=3D1M count=3D100
> 100+0 records in
> 100+0 records out
> 104857600 bytes (105 MB, 100 MiB) copied, 0.0386658 s, 2.7 GB/s
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkfs /tmp/=
nfs.img
> mke2fs 1.46.1 (9-Feb-2021)
> Discarding device blocks:   1024/102400=08=08=08=08=08=08=08=08=08=08=08=08=
=08             =08=08=08=08=08=08=08=08=08=08=08=08=08done
> Creating filesystem with 102400 1k blocks and 25688 inodes
> Filesystem UUID: 77e3bc56-46bb-4e5c-9619-d9a0c0999958
> Superblock backups stored on blocks:
> 	8193, 24577, 40961, 57345, 73729
>=20
> Allocating group tables:  0/13=08=08=08=08=08     =08=08=08=08=08done
> Writing inode tables:  0/13=08=08=08=08=08     =08=08=08=08=08done
> Writing superblocks and filesystem accounting information:  0/13=08=08=08=
=08=08     =08=08=08=08=08done
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount /tmp=
/nfs.img /mnt
>=20
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkdir /mnt=
/nfs_root
>=20
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# touch /etc=
/exports
>=20
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# echo '/mnt=
/nfs_root *(insecure,rw,async,no_root_squash)' >> /etc/exports
>=20
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# /opt/wr-te=
st/bin/svcwp.sh nfsserver restart
> stopping mountd: done
> stopping nfsd: ..........failed
>   using signal 9:
> ..........failed

What does your "nfsserver" script do to try to stop/restart the nfsd?
For a very long time the approved way to stop nfsd has been to run
"rpc.nfsd 0".  My guess is that whatever script you are using still
trying to send a signal to nfsd.  That no longer works.

Unfortunately the various sysv-init scripts for starting/stopping nfsd
have never been part of nfs-utils so we were not able to update them.
nfs-utils *does* contain systemd unit files for sites which use systemd.

If you have a non-systemd way of starting/stopping nfsd, we would be
happy to make the relevant scripts part of nfs-utils so that we can
ensure they stay up to date.

Thanks,
NeilBrown

