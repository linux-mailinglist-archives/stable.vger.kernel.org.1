Return-Path: <stable+bounces-37679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC7089C5F6
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDD61C23D22
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4727F467;
	Mon,  8 Apr 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hKM8G2kW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE67BB15;
	Mon,  8 Apr 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584943; cv=none; b=hHAQYJbt3KNvIzeaPIGxk9IcN5JibW+UTM4xdD7Rf7t9sBBQmfbbWKGMczr0gKqTyar++uMw96OSe/7/bc/z9IaM6YL8kH7YfWkGfbpzbixhztRDzRsDruvcArWVUXBDahPM/ZfpDzVZ4Rhn7pBWlkcQ+lM0zo2KYa2c+ZE2qY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584943; c=relaxed/simple;
	bh=rwsmPCVFOdzrn6qUomHsarnHWO4IP+PruIqR2Xzt91Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qdr1JgZTeuJ7kHMiH0e+Bw1MsW29MHTqOZUfAcK2pthkO23Ndg7wwq1Jl2283CuOIhZIEPrt99YqECZ9E5TRuW9ZnKZIyidbl8xc4i25iapvwkGRr8rcFRJ7gU5PiLlj8ur0wsGB5B4Uf/rRcGR48YalkY+ST+mRbu81hpZ33ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hKM8G2kW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DBAC433F1;
	Mon,  8 Apr 2024 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584943;
	bh=rwsmPCVFOdzrn6qUomHsarnHWO4IP+PruIqR2Xzt91Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKM8G2kWkz6dqJCJZn29Jlh/FEt7rW9HsDw7ra2MI4jAe99YBoDkqTomjYnqI0nLs
	 jteLiAiwiuO8u8vqwtkuG6YCW9pEytYUk6oELmTAmfPY0T6W3VK8HGf/OqMual0H8x
	 VjBWMIwxBCEVyyJTC6hWwkzEkQN11Zw3Q3Nvt6TA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+c645abf505ed21f931b5@syzkaller.appspotmail.com,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 582/690] scsi: core: Fix unremoved procfs host directory regression
Date: Mon,  8 Apr 2024 14:57:28 +0200
Message-ID: <20240408125420.670198439@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guilherme G. Piccoli <gpiccoli@igalia.com>

commit f23a4d6e07570826fe95023ca1aa96a011fa9f84 upstream.

Commit fc663711b944 ("scsi: core: Remove the /proc/scsi/${proc_name}
directory earlier") fixed a bug related to modules loading/unloading, by
adding a call to scsi_proc_hostdir_rm() on scsi_remove_host(). But that led
to a potential duplicate call to the hostdir_rm() routine, since it's also
called from scsi_host_dev_release(). That triggered a regression report,
which was then fixed by commit be03df3d4bfe ("scsi: core: Fix a procfs host
directory removal regression"). The fix just dropped the hostdir_rm() call
from dev_release().

But it happens that this proc directory is created on scsi_host_alloc(),
and that function "pairs" with scsi_host_dev_release(), while
scsi_remove_host() pairs with scsi_add_host(). In other words, it seems the
reason for removing the proc directory on dev_release() was meant to cover
cases in which a SCSI host structure was allocated, but the call to
scsi_add_host() didn't happen. And that pattern happens to exist in some
error paths, for example.

Syzkaller causes that by using USB raw gadget device, error'ing on
usb-storage driver, at usb_stor_probe2(). By checking that path, we can see
that the BadDevice label leads to a scsi_host_put() after a SCSI host
allocation, but there's no call to scsi_add_host() in such path. That leads
to messages like this in dmesg (and a leak of the SCSI host proc
structure):

usb-storage 4-1:87.51: USB Mass Storage device detected
proc_dir_entry 'scsi/usb-storage' already registered
WARNING: CPU: 1 PID: 3519 at fs/proc/generic.c:377 proc_register+0x347/0x4e0 fs/proc/generic.c:376

The proper fix seems to still call scsi_proc_hostdir_rm() on dev_release(),
but guard that with the state check for SHOST_CREATED; there is even a
comment in scsi_host_dev_release() detailing that: such conditional is
meant for cases where the SCSI host was allocated but there was no calls to
{add,remove}_host(), like the usb-storage case.

This is what we propose here and with that, the error path of usb-storage
does not trigger the warning anymore.

Reported-by: syzbot+c645abf505ed21f931b5@syzkaller.appspotmail.com
Fixes: be03df3d4bfe ("scsi: core: Fix a procfs host directory removal regression")
Cc: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Link: https://lore.kernel.org/r/20240313113006.2834799-1-gpiccoli@igalia.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/hosts.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -334,12 +334,13 @@ static void scsi_host_dev_release(struct
 
 	if (shost->shost_state == SHOST_CREATED) {
 		/*
-		 * Free the shost_dev device name here if scsi_host_alloc()
-		 * and scsi_host_put() have been called but neither
+		 * Free the shost_dev device name and remove the proc host dir
+		 * here if scsi_host_{alloc,put}() have been called but neither
 		 * scsi_host_add() nor scsi_host_remove() has been called.
 		 * This avoids that the memory allocated for the shost_dev
-		 * name is leaked.
+		 * name as well as the proc dir structure are leaked.
 		 */
+		scsi_proc_hostdir_rm(shost->hostt);
 		kfree(dev_name(&shost->shost_dev));
 	}
 



