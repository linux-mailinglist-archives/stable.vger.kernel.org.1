Return-Path: <stable+bounces-18874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A00A84AB54
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 02:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389EB1C23FA4
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A829A137E;
	Tue,  6 Feb 2024 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="AV8iPH4R"
X-Original-To: stable@vger.kernel.org
Received: from egress-ip12a.ess.de.barracuda.com (egress-ip12a.ess.de.barracuda.com [18.184.203.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460E4A06
	for <stable@vger.kernel.org>; Tue,  6 Feb 2024 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.184.203.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181192; cv=none; b=Vl3sC722oAWDObBTlLtXs2nTwBlJE4Hp+Ni6RJCiniy2vWyf61/4n2octgSWvZwccquy2IK8YHzVbhxnMAVt/LyjsozS/QroHb98+vWA16WVbCEoTKSvHaTD7H6KIeRcSWDleGqqlaUizPDzqJPr1PNzpzbpA81vQje5+hIKE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181192; c=relaxed/simple;
	bh=PFuA5xdtIgOFSyw72kpYF/uFFQ62cuFVyjApG9Z1ftI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwHCJOWNT72wSyh0gQb8fiLxTND/uhRrJarcSfeUrT7fQjj9jRLiOXWWOjz7fNlMSYBqUGNrABeJkKpWgkSqGndMsuoYZ9mPOA9W+//uGCUiZticvjuvJ5xb0GLr0sA3l5ig7M93bsBmoWw41uhue2XP7XFtuKMxdrc6DRr1PA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=AV8iPH4R; arc=none smtp.client-ip=18.184.203.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198]) by mx-outbound10-206.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 06 Feb 2024 00:59:48 +0000
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d486bce39bso40206425ad.1
        for <stable@vger.kernel.org>; Mon, 05 Feb 2024 16:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1707181185; x=1707785985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbWRmcBkwMEecTwCDQa265tRUPfMy5uFyAEgQ22r9b8=;
        b=AV8iPH4R4HndhYhWatGBkVUAbsDDxNh0cntdBBuXFJyWcufbIRvhyh1xsoxs0lE6Aa
         v+SNyBgrcArrXBDk1Dgd3tp7Ma832OCdVdaOSnhuGrU3dOMKsIZ4pmwMb9BZPOLal6tY
         d+KYls4aavWKYTNMOZtWzIc5PXccWrDLV5ayQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181185; x=1707785985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbWRmcBkwMEecTwCDQa265tRUPfMy5uFyAEgQ22r9b8=;
        b=xGJiJuHoVFXwDiHvMltl0Zq6nHhTKU+lBuVB/2bhdH/KvmJ4v63L8t2DwJZejKK1xD
         7l40LZWdavwwEfyF9rz4LNnAr1K9YSXliqJO/BC7W/pjS0GSAg72ieR+aK8ELgWfA0zZ
         g24O+vKXNHQ3vrCTJu75lUoEFbJD/PgUkXkEX2vJrlKkuYzys+YeMipwI8xRMFeN/byC
         dysfsXhRa3vUuabQqSs7iDlx5ZlyGnn8hwNWgClxBWelnEjOga6Brw/8C9jCQdCVBdhp
         PHrQjL/e6tu4cDphjQWBgEh1zQtc/oN0NCRoTwp/j9/zAqFG/qw4hpbR3DkISicJKcAU
         j+bQ==
X-Gm-Message-State: AOJu0Yz7NXWmo9uzVo1n/lIyZypga64rXTqUlr+RVNHTB9vfIXnqZmQ3
	LYi8ylMI8ug5b+7zRjvGmDDn/xNH+xDn+PP1NEx4OENploTL5jERmgO39P1Vn6nrWbujWYN0Gl9
	MPjWdc7XVMhCrNQuRX1eJsws+bWONyNHNwlG3DyMuXAo4tS7dqr98lnEt4Bqd3dehw3aCwydDSD
	sR0DbXn/yCvZLmTHwcPLGA
X-Received: by 2002:a17:903:48d:b0:1d9:620b:89cb with SMTP id jj13-20020a170903048d00b001d9620b89cbmr187737plb.13.1707181185317;
        Mon, 05 Feb 2024 16:59:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOAtgjSgJxtQ0OWsnBbJCqmPgsXPZ+A3CqZT44gif2wpYXXlhNKWQ4M2WB42yhHBLvg0k4kw==
X-Received: by 2002:a17:903:48d:b0:1d9:620b:89cb with SMTP id jj13-20020a170903048d00b001d9620b89cbmr187720plb.13.1707181185001;
        Mon, 05 Feb 2024 16:59:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWz/WSqyM10dRAG0UpNtz48TCpwSK/9J6LcnyWL7CyLcLv7sHdiB5wyp6X9o2IaDjsJ7MrT7O77b38629bOz/H1BtbigQrNgoVY5xi+jUndtH41j9kZ3H9JYa+wk1eBP26O2xxlClOfXFSeSvcwpBkGMiX3SFV9pqyFxmQHn7S7eQrL3p1l+0k1FShba1fWhxbm/p8OrgZ3TVdAt3omfxroGoJ4GK2g/Jw8UaRwT2Tj
Received: from localhost.localdomain ([49.207.212.181])
        by smtp.gmail.com with ESMTPSA id le11-20020a170902fb0b00b001d8f251c8b2sm496534plb.221.2024.02.05.16.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:59:44 -0800 (PST)
From: Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To: Denis Kirjanov <dkirjanov@suse.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	Sinthu Raja <sinthu.raja@ti.com>,
	stable@vger.kernel.org
Subject: [PATCH V3 2/2] net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio
Date: Tue,  6 Feb 2024 06:29:28 +0530
Message-Id: <20240206005928.15703-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240206005928.15703-1-sinthu.raja@ti.com>
References: <20240206005928.15703-1-sinthu.raja@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1707181187-302766-3502-4670-1
X-BESS-VER: 2019.1_20240205.2236
X-BESS-Apparent-Source-IP: 209.85.214.198
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyMrI0AbIygILmiaYmJmZmqW
	aJSUaGZkbmxmbJacYpqSYmhpaJxmlJiUq1sQABbgJlQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254014 [from 
	cloudscan10-250.eu-central-1a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Sinthu Raja <sinthu.raja@ti.com>

The below commit  introduced a WARN when phy state is not in the states:
PHY_HALTED, PHY_READY and PHY_UP.
commit 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")

When cpsw resumes, there have port in PHY_NOLINK state, so the below
warning comes out. Set mac_managed_pm be true to tell mdio that the phy
resume/suspend is managed by the mac, to fix the following warning:

WARNING: CPU: 0 PID: 965 at drivers/net/phy/phy_device.c:326 mdio_bus_phy_resume+0x140/0x144
CPU: 0 PID: 965 Comm: sh Tainted: G           O       6.1.46-g247b2535b2 #1
Hardware name: Generic AM33XX (Flattened Device Tree)
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x24/0x2c
 dump_stack_lvl from __warn+0x84/0x15c
 __warn from warn_slowpath_fmt+0x1a8/0x1c8
 warn_slowpath_fmt from mdio_bus_phy_resume+0x140/0x144
 mdio_bus_phy_resume from dpm_run_callback+0x3c/0x140
 dpm_run_callback from device_resume+0xb8/0x2b8
 device_resume from dpm_resume+0x144/0x314
 dpm_resume from dpm_resume_end+0x14/0x20
 dpm_resume_end from suspend_devices_and_enter+0xd0/0x924
 suspend_devices_and_enter from pm_suspend+0x2e0/0x33c
 pm_suspend from state_store+0x74/0xd0
 state_store from kernfs_fop_write_iter+0x104/0x1ec
 kernfs_fop_write_iter from vfs_write+0x1b8/0x358
 vfs_write from ksys_write+0x78/0xf8
 ksys_write from ret_fast_syscall+0x0/0x54
Exception stack(0xe094dfa8 to 0xe094dff0)
dfa0:                   00000004 005c3fb8 00000001 005c3fb8 00000004 00000001
dfc0: 00000004 005c3fb8 b6f6bba0 00000004 00000004 0059edb8 00000000 00000000
dfe0: 00000004 bed918f0 b6f09bd3 b6e89a66

Cc: <stable@vger.kernel.org> # v6.0+
Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index ea85c6dd5484..c0a5abd8d9a8 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -631,6 +631,8 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 		}
 	}
 
+	phy->mac_managed_pm = true;
+
 	slave->phy = phy;
 
 	phy_attached_info(slave->phy);
-- 
2.36.1


