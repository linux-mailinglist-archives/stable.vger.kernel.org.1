Return-Path: <stable+bounces-114331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83529A2D0FC
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FBC16D5FA
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC761C5F1D;
	Fri,  7 Feb 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH9yJeJN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1231AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968671; cv=none; b=ulJrDhe8ABPj/6L7qhbQ615+mlA0Eu4z/++nKZ0LPq/9Yh2IqIQ7kuedLXpuSDdH+4aEOkX65L36S0TBnGlaE1u/mf1YnY9ukiyLNf6jfeN0j55daMPgublDMDeE+7Yys5mxiLHbfEYZ/In6eYG9RAHYw9Omoa80gIIMBLFxZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968671; c=relaxed/simple;
	bh=feVEi0a4MlyytA7J43QY8Ox9zvdAP1RjHc0x7EQE4n8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JivVxDtCfNmnnxxALBontA1FjNRzKh39B4Wm7gbKnWj56NYtonQ6PIqZKJfGFPuQ+zBdHDzoQxXim/8iHRmtND9/FmiKd9Klm8W+yKJejk3ySj2oaePa68zNHcgIFiTNS8hDjvRZRnA2ae7vwy3KCQGL3itZV0ynznXbT47kcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH9yJeJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99F2C4CED1;
	Fri,  7 Feb 2025 22:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968671;
	bh=feVEi0a4MlyytA7J43QY8Ox9zvdAP1RjHc0x7EQE4n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gH9yJeJNq6BarTOfh9rPTB0JmR8IYN0YPu+/OJU8qsjRSw1DkjgQFiHlWZ3xzyF37
	 ri9hy3wHOVhskdr02pf95tp09wtFZSQMiD/8Ac0iq/IXTqqBVxBOg+HdNwTYPKrkDW
	 nl8ye0ts3Wr0kBjhRIM1BKtngKHYFBX0DjPFQ50WbAZ013SFLwjdW42ALRJot9C+Jr
	 BVgNI4jY7O+UeTzaizhr1n8HRWdEWDIwQE3mFGI/aLiPhxlftT0SmqTHXI6BRtNFRs
	 VRsEpM55ywGL/k5F7VoXj0b/8aLBoGSAP/DNbQsS1duCu3ZboQNt2hrTBtFp6bDkR4
	 aRj8+L7Okj6uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Calvin Owens <calvin@wbinvd.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] pps: Fix a use-after-free
Date: Fri,  7 Feb 2025 17:51:09 -0500
Message-Id: <20250207153310-2bc259bc590da831@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <a79cc7764ee98771a74a62e1dfc3d398461e4187.1738811041.git.calvin@wbinvd.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: c79a39dc8d060b9e64e8b0fa9d245d44befeefbe


Status in newer kernel trees:
6.13.y | Present (different SHA1: d487d68916ad)
6.12.y | Present (different SHA1: 2423d77f7ee9)
6.6.y | Present (different SHA1: 73f8d5a93c8f)
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c79a39dc8d060 ! 1:  4ded4bb10e446 pps: Fix a use-after-free
    @@ Commit message
         Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
         Link: https://lore.kernel.org/r/a17975fd5ae99385791929e563f72564edbcf28f.1731383727.git.calvin@wbinvd.org
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    (cherry picked from commit c79a39dc8d060b9e64e8b0fa9d245d44befeefbe)
    +    Signed-off-by: Calvin Owens <calvin@wbinvd.org>
     
      ## drivers/pps/clients/pps-gpio.c ##
     @@ drivers/pps/clients/pps-gpio.c: static int pps_gpio_probe(struct platform_device *pdev)
    @@ drivers/pps/clients/pps-ktimer.c: static int __init pps_ktimer_init(void)
      }
     
      ## drivers/pps/clients/pps-ldisc.c ##
    -@@ drivers/pps/clients/pps-ldisc.c: static void pps_tty_dcd_change(struct tty_struct *tty, bool active)
    - 	pps_event(pps, &ts, active ? PPS_CAPTUREASSERT :
    +@@ drivers/pps/clients/pps-ldisc.c: static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
    + 	pps_event(pps, &ts, status ? PPS_CAPTUREASSERT :
      			PPS_CAPTURECLEAR, NULL);
      
     -	dev_dbg(pps->dev, "PPS %s at %lu\n",
     +	dev_dbg(&pps->dev, "PPS %s at %lu\n",
    - 			active ? "assert" : "clear", jiffies);
    + 			status ? "assert" : "clear", jiffies);
      }
      
     @@ drivers/pps/clients/pps-ldisc.c: static int pps_tty_open(struct tty_struct *tty)
    @@ drivers/pps/pps.c: EXPORT_SYMBOL(pps_lookup_dev);
      {
     -	int err;
     -
    - 	pps_class = class_create("pps");
    + 	pps_class = class_create(THIS_MODULE, "pps");
      	if (IS_ERR(pps_class)) {
      		pr_err("failed to allocate class\n");
     @@ drivers/pps/pps.c: static int __init pps_init(void)
    @@ drivers/pps/pps.c: static int __init pps_init(void)
      
      subsys_initcall(pps_init);
     
    - ## drivers/ptp/ptp_ocp.c ##
    -@@ drivers/ptp/ptp_ocp.c: ptp_ocp_complete(struct ptp_ocp *bp)
    - 
    - 	pps = pps_lookup_dev(bp->ptp);
    - 	if (pps)
    --		ptp_ocp_symlink(bp, pps->dev, "pps");
    -+		ptp_ocp_symlink(bp, &pps->dev, "pps");
    - 
    - 	ptp_ocp_debugfs_add_device(bp);
    - 
    -
      ## include/linux/pps_kernel.h ##
     @@ include/linux/pps_kernel.h: struct pps_device {
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.10.y:
    In file included from ./include/linux/kernel.h:15,
                     from ./include/linux/list.h:9,
                     from ./include/linux/kobject.h:19,
                     from ./include/linux/of.h:17,
                     from ./include/linux/clk-provider.h:9,
                     from drivers/clk/qcom/clk-rpmh.c:6:
    drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
    ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
          |                                   ^~
    ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
       26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
       36 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
       45 | #define min(x, y)       __careful_cmp(x, y, <)
          |                         ^~~~~~~~~~~~~
    drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
      273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
          |                     ^~~
    In file included from ./include/linux/mm.h:30,
                     from ./include/linux/pagemap.h:8,
                     from ./include/linux/buffer_head.h:14,
                     from fs/udf/udfdecl.h:12,
                     from fs/udf/super.c:41:
    fs/udf/super.c: In function 'udf_fill_partdesc_info':
    ./include/linux/overflow.h:70:22: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       70 |         (void) (&__a == &__b);                  \
          |                      ^~
    fs/udf/super.c:1155:21: note: in expansion of macro 'check_add_overflow'
     1155 |                 if (check_add_overflow(map->s_partition_len,
          |                     ^~~~~~~~~~~~~~~~~~
    Segmentation fault
    make: *** [Makefile:1207: vmlinux] Error 139
    make: Target '__all' not remade because of errors.

