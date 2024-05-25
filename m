Return-Path: <stable+bounces-46137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15D8CEF6F
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4F32819BF
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED3774E10;
	Sat, 25 May 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qm0rop6G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF10634E2;
	Sat, 25 May 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648512; cv=none; b=kaTvkGr8WEvlKtaNGAws2W82RMOe4J9TsENZ49HL0YOU+NJEi+RGxMzWJZwKtQGp8qXwIepklCnXfqiP++9vIWHJt8uiW/xT+M///dZFGb9/4DSaCj65Cl0haF/VSb4u2yPRkzlqEJ7Ni81eifbnqW5BzJo2fGhhjxxLFIsuCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648512; c=relaxed/simple;
	bh=Cylrbg+QYe7bzHB6Bs4lHY6JQjx+yRvXoZMAnp4Scj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BGe0BYK6UcRCtx+/T4lW+GN8FhcLJf4JWqK3ZQCshDIDwPhw5dmuYCIEROdx2Jhwcl8CBmAna7XyNrna1ISE0eYI69+Bss4NmqKYU5ZFzMw4Uob+g+qGqKNhiSqUwnFyvvapMvu/rfFCbpwtwgNJW9xSfWVH6x1SiKar31JU4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qm0rop6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBEEC2BD11;
	Sat, 25 May 2024 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648512;
	bh=Cylrbg+QYe7bzHB6Bs4lHY6JQjx+yRvXoZMAnp4Scj8=;
	h=From:To:Cc:Subject:Date:From;
	b=qm0rop6GdSMlqMWMk4/WFoysjdm0jIP280ZYFMdfu7ETJLKrdZxFJd9UP/yVF8v8b
	 pDrMHL5ZEbpPIA5imeXHSulDgQKAtk61YnDpaIVd8g1cViCddvywBKog63sXBl87Vn
	 9M3tLfpgK3cfX1dwEjcfiJXuyb2ftUZyCeY9fhIw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.160
Date: Sat, 25 May 2024 16:48:27 +0200
Message-ID: <2024052527-backstab-accustom-b31f@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.160 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/core-scheduling.rst |    4 
 Documentation/sphinx/kernel_include.py                |    1 
 Makefile                                              |    2 
 arch/x86/kvm/x86.c                                    |   11 
 drivers/android/binder.c                              |    2 
 drivers/android/binder_internal.h                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c               |    3 
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c           |    7 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c        |   12 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.h        |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c    |    6 
 drivers/net/ethernet/broadcom/genet/bcmmii.c          |    4 
 drivers/pinctrl/core.c                                |   14 -
 drivers/remoteproc/mtk_scp.c                          |   10 
 drivers/tty/serial/kgdboc.c                           |   30 ++
 drivers/usb/typec/ucsi/displayport.c                  |    4 
 fs/nfs/callback.c                                     |    9 
 fs/nfsd/nfs4proc.c                                    |    5 
 fs/nfsd/nfssvc.c                                      |   12 -
 include/net/tls.h                                     |    6 
 net/netlink/af_netlink.c                              |   23 +-
 net/sunrpc/svc_xprt.c                                 |   16 -
 net/tls/tls_sw.c                                      |  199 +++++++++---------
 security/keys/trusted-keys/trusted_tpm2.c             |   25 +-
 tools/testing/selftests/vm/map_hugetlb.c              |    7 
 25 files changed, 242 insertions(+), 174 deletions(-)

Akira Yokosawa (1):
      docs: kernel_include.py: Cope with docutils 0.21

AngeloGioacchino Del Regno (1):
      remoteproc: mediatek: Make sure IPI buffer fits in L2TCM

Carlos Llamas (1):
      binder: fix max_thread type inconsistency

Daniel Thompson (1):
      serial: kgdboc: Fix NMI-safety problems from keyboard reset code

Doug Berger (2):
      net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
      net: bcmgenet: synchronize UMAC_CMD access

Eric Dumazet (2):
      netlink: annotate lockless accesses to nlk->max_recvmsg_len
      netlink: annotate data-races around sk->sk_err

Greg Kroah-Hartman (1):
      Linux 5.15.160

Harshit Mogalapalli (1):
      Revert "selftests: mm: fix map_hugetlb failure on 64K page size systems"

Heikki Krogerus (1):
      usb: typec: ucsi: displayport: Fix potential deadlock

Jakub Kicinski (4):
      tls: rx: simplify async wait
      net: tls: factor out tls_*crypt_async_wait()
      tls: fix race between async notify and socket close
      net: tls: handle backlogging of crypto requests

Jarkko Sakkinen (2):
      KEYS: trusted: Fix memory leak in tpm2_key_encode()
      KEYS: trusted: Do not use WARN when encode fails

Jose Fernandez (1):
      drm/amd/display: Fix division by zero in setup_dsc_config

NeilBrown (1):
      nfsd: don't allow nfsd threads to be signalled.

Sabrina Dubroca (1):
      tls: extract context alloc/initialization out of tls_set_sw_offload

Sean Christopherson (1):
      KVM: x86: Clear "has_error_code", not "error_code", for RM exception injection

Sergey Shtylyov (1):
      pinctrl: core: handle radix_tree_insert() errors in pinctrl_register_one_pin()

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix possible NULL dereference in amdgpu_ras_query_error_status_helper()

Thomas Weißschuh (1):
      admin-guide/hw-vuln/core-scheduling: fix return type of PR_SCHED_CORE_GET


