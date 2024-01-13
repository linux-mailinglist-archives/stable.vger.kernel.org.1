Return-Path: <stable+bounces-10640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30C82CAFE
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC44B20F3A
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8D17E8;
	Sat, 13 Jan 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jYKCWxF1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC0EC5;
	Sat, 13 Jan 2024 09:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23FCC433C7;
	Sat, 13 Jan 2024 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139671;
	bh=oxm94l1JTw6aHl5Skk8QTNgIEoZwUkf0pv+aRmzXTjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYKCWxF1SsWdDELGoQHh/UIrKBSQXXWXk2gYuCEgbaW77Eh4mZikin0VsocnNdRhW
	 4N2ecB6hU+mKhwnMLsp661uNKbRmufv/V9XM6VYvEE2GLVi0kO6p48trqojePtw+Gb
	 IGMD5YmJPvmko0o/ecCDpo/TIKx28DNR+PUnz1rE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 17/25] mmc: core: Cancel delayed work before releasing host
Date: Sat, 13 Jan 2024 10:49:58 +0100
Message-ID: <20240113094205.582947827@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094205.025407355@linuxfoundation.org>
References: <20240113094205.025407355@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1036f69e251380573e256568cf814506e3fb9988 upstream.

On RZ/Five SMARC EVK, where probing of SDHI is deferred due to probe
deferral of the vqmmc-supply regulator:

    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1738 __run_timers.part.0+0x1d0/0x1e8
    Modules linked in:
    CPU: 0 PID: 0 Comm: swapper Not tainted 6.7.0-rc4 #101
    Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
    epc : __run_timers.part.0+0x1d0/0x1e8
     ra : __run_timers.part.0+0x134/0x1e8
    epc : ffffffff800771a4 ra : ffffffff80077108 sp : ffffffc800003e60
     gp : ffffffff814f5028 tp : ffffffff8140c5c0 t0 : ffffffc800000000
     t1 : 0000000000000001 t2 : ffffffff81201300 s0 : ffffffc800003f20
     s1 : ffffffd8023bc4a0 a0 : 00000000fffee6b0 a1 : 0004010000400000
     a2 : ffffffffc0000016 a3 : ffffffff81488640 a4 : ffffffc800003e60
     a5 : 0000000000000000 a6 : 0000000004000000 a7 : ffffffc800003e68
     s2 : 0000000000000122 s3 : 0000000000200000 s4 : 0000000000000000
     s5 : ffffffffffffffff s6 : ffffffff81488678 s7 : ffffffff814886c0
     s8 : ffffffff814f49c0 s9 : ffffffff81488640 s10: 0000000000000000
     s11: ffffffc800003e60 t3 : 0000000000000240 t4 : 0000000000000a52
     t5 : ffffffd8024ae018 t6 : ffffffd8024ae038
    status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
    [<ffffffff800771a4>] __run_timers.part.0+0x1d0/0x1e8
    [<ffffffff800771e0>] run_timer_softirq+0x24/0x4a
    [<ffffffff80809092>] __do_softirq+0xc6/0x1fa
    [<ffffffff80028e4c>] irq_exit_rcu+0x66/0x84
    [<ffffffff80800f7a>] handle_riscv_irq+0x40/0x4e
    [<ffffffff80808f48>] call_on_irq_stack+0x1c/0x28
    ---[ end trace 0000000000000000 ]---

What happens?

    renesas_sdhi_probe()
    {
    	tmio_mmc_host_alloc()
	    mmc_alloc_host()
		INIT_DELAYED_WORK(&host->detect, mmc_rescan);

	devm_request_irq(tmio_mmc_irq);

	/*
	 * After this, the interrupt handler may be invoked at any time
	 *
	 *  tmio_mmc_irq()
	 *  {
	 *	__tmio_mmc_card_detect_irq()
	 *	    mmc_detect_change()
	 *		_mmc_detect_change()
	 *		    mmc_schedule_delayed_work(&host->detect, delay);
	 *  }
	 */

	tmio_mmc_host_probe()
	    tmio_mmc_init_ocr()
		-EPROBE_DEFER

	tmio_mmc_host_free()
	    mmc_free_host()
    }

When expire_timers() runs later, it warns because the MMC host structure
containing the delayed work was freed, and now contains an invalid work
function pointer.

Fix this by cancelling any pending delayed work before releasing the
MMC host structure.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/205dc4c91b47e31b64392fe2498c7a449e717b4b.1701689330.git.geert+renesas@glider.be
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/host.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -489,6 +489,7 @@ EXPORT_SYMBOL(mmc_remove_host);
  */
 void mmc_free_host(struct mmc_host *host)
 {
+	cancel_delayed_work_sync(&host->detect);
 	mmc_pwrseq_free(host);
 	put_device(&host->class_dev);
 }



