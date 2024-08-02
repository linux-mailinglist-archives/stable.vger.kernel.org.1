Return-Path: <stable+bounces-65278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AA49456D7
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 06:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233D61C2113A
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 04:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8E211C;
	Fri,  2 Aug 2024 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JDfHsQFZ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586251C698
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571552; cv=none; b=Cn8JXReg3UIWimlERExGk7b2M5GBVvrJ+s1eWfXJ3y1GfcaJ0+FCttmAzQY/18KgsLkETVyL/6bsbxLia9b5LzTtCEScCt5aEo+WfxZWbqTjSJWRogAOig0RsGnVWZTCTLDKnEcsN2P8CS7X/ft1+D7NsRhBLUjLYquWX2petlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571552; c=relaxed/simple;
	bh=ul6i/GFKPOUdRAbavNszc3l/tJwEOl6+D4VlVj1WAoE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DWWVqwxOLYtpp39Rto+zUBNT/7hWeBV6GKzpPDR4NOLi+ayBWl05cDDwuIdblcqYDfzRed84j6/JEVDW8ud0gNnVNd62w4Om5OAqLvWGezR3ImcAtTsSHq2EhpDimd5XTYvO3bTETSKNvPkwTyRLhgFpsXBWZlWrr8C7MoMD/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JDfHsQFZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 5208D20B7165; Thu,  1 Aug 2024 21:05:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5208D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722571545;
	bh=pv4cgtO7qRsoqwrnBni3UGJaUYU6DNaVWzUj0RbM57c=;
	h=From:To:Cc:Subject:Date:From;
	b=JDfHsQFZbeetsP5YgdatSKEKNUoW2WvxT5dDgmaf8Qp/CPLrET9G+UVPQDUlfR9Nb
	 lA9nAo3AWy02ziwcf3+PSWZj+S++CxigVWvHNErtjea/PZg53d7FDkdXXNpqfhCX1X
	 wqAG4dlnBXO5/OpgafSK9gMAj3ayB8TtQj+/2Iog=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	chen.dylane@gmail.com,
	t-anchiang@microsoft.com
Subject: bpf tool build failure in latest stable-rc 6.1.103-rc3 due to missing backport
Date: Thu,  1 Aug 2024 21:05:45 -0700
Message-Id: <1722571545-7009-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

bpf tool build fails for the latest stable-rc 6.1.103-rc3
The error details are as follows:
prog.c: In function 'load_with_options':
prog.c:1710:23: warning: implicit declaration of function 'create_and_mount_bpffs_dir' [-Wimplicit-function-declaration]
 1710 |                 err = create_and_mount_bpffs_dir(pinmaps);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
  CC      struct_ops.o
  CC      tracelog.o
  CC      xlated_dumper.o
  CC      jit_disasm.o
  CC      disasm.o
  LINK    bpftool
/usr/bin/ld: prog.o: in function `load_with_options':
prog.c:(.text+0x346a): undefined reference to `create_and_mount_bpffs_dir'

The commit causing this failure in 6.1.103-rc3: bc1605fcb33bf7a300cd3ac5c409a16bda1626ba

It appears that the commit from the 6.10 series is missing in this release candidate:
478a535ae54a ("bpftool: Mount bpffs on provided dir instead of parent dir")



Thanks,
Hardik

