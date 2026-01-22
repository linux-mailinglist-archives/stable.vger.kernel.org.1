Return-Path: <stable+bounces-211241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDrUJ8Q3cmmadwAAu9opvQ
	(envelope-from <stable+bounces-211241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:44:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43E6810E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B9596AB12A
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC643115BD;
	Thu, 22 Jan 2026 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nappairam.dev header.i=@nappairam.dev header.b="fFKJ0F6p"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DED3115B5
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089299; cv=pass; b=qQ/5+577MAOA4aiJwXsXCrNN+8XHKa1QPo6g3eHpIU+IGY1MhM/0wC5augaxzLu5ODAwsIa+TIdMZ1rMbmv6Zy/gczk95Un4UzhesS3VxClEqVDIipyh9GoBmHZeqLDwe6FEtycunLJz5vOThfaJOqiThU5usdLTYWV4fJTUAIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089299; c=relaxed/simple;
	bh=w2P21e8Xrn00dZ0P+iuyYVl+3bMyas+UXks6Iy2oCiM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=txzlfBs+vTXJayo9GiG9pA8wHBc/WVbOsVtSvA6hy6E5xaDjntq2k5js97FDlxA5WCaucM54rQhcn+DUDJqN2ELFrrZuqhy5cs7p+VZsdOQDnnC8zzmLakNxSQBqew0vekNDsMNYd6zHQ208Cppr5+lW4h5vkhiyay4n1QzVi5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nappairam.dev; spf=none smtp.mailfrom=nappairam.dev; dkim=pass (2048-bit key) header.d=nappairam.dev header.i=@nappairam.dev header.b=fFKJ0F6p; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nappairam.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nappairam.dev
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6455a60c12bso902320d50.3
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 05:41:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769089295; cv=none;
        d=google.com; s=arc-20240605;
        b=JL5gjjnp405tqsQMGaZMarbNS0N0kSZDbp9QJdS2m2FGjNAxd1n7GZUv3dDOX/sIDh
         G3CAloPV0YMCTD8T7JytHKyFDVxept9A/fa5PrkRgJEJGuDnm7IOyAHPhfGn9sr3DwzS
         pzwFKc4kZ9l7tl2Zx9d0qSy+y+jZhh7oYKmQyXdPhTAadJJf/bacqLTvxir1zBvUswu/
         1Cx1vM5X0DhIl6jCPoM0b/DyVrR9701/5f6wSVdNfXyz2mFOUgkosJvIYbt3p2BFa3+y
         UVMWuibsuToaS6cP10rDE0wBbh/O9ZGukIGAaxkYuDlR4xy3MzTPbZRxrwIwkv1xoCsc
         7m+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w2P21e8Xrn00dZ0P+iuyYVl+3bMyas+UXks6Iy2oCiM=;
        fh=KqPjItzF2ztS83oLq6umyWlgsBCq7hgMbif7KF+vZ8o=;
        b=IHhI8xnzkJL6HEGv8T6vZd0realca8BnVV3SPzwFlTCDThuZ+YRG8/O2yPIKf+DQPZ
         fi6d+M+IebYCxEkDzrKSzUeky0t8tv/JetObMa0JmhbgK5HsHgH2qGvgSN7Up8svP9YV
         9BaWrVgR2CMCnhvc2js2i9g2/ipSHr1en8fpozLYOuOM4fGGtU3laHR8iDvwLlDk5c/d
         LhahDSeE2PL/uuUTyknOaJhAIszkFS3zFKZsN+GWkrS6vUseTYiK/PEFzEQ0lYqZeL0Q
         PPoedMUCo8Zt5/5IX7L/y9+wYtFy8WF/o0Iqq21Ewlbmtdh1KyaXo56UpiU7G7J49wNq
         PF7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nappairam.dev; s=google; t=1769089295; x=1769694095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2P21e8Xrn00dZ0P+iuyYVl+3bMyas+UXks6Iy2oCiM=;
        b=fFKJ0F6pr5E/0ZbdZp89+o2U1hp0Aq5XSj0rpSzNcIgYLcfOe0J/dvfD71282/kVFk
         EH86CTf2QDSCB7VOwqw7BsReLtM9GiRWrm3/s7YqJCxVJwVfKpPH6gK5gPiukWwxDNed
         pdU+OwgILOk/8A5hVAm5G8nX9tPlVKRJRRplB1+uPlQ0W8D6hBJOqWNUYbXmfAZGaqId
         taTzQTpfF6eIEWBfvLzKcqbsXGrCUDPy0rAzrzVZvHs8zwBzC9FzR1+N2h9/XATqGUq5
         tpxUz3/J7A4wI4dZOCF5P59iFI8DPkFzn/BvKY7svk351WN1zCZMzUiFudBhz80sxVau
         l4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769089295; x=1769694095;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2P21e8Xrn00dZ0P+iuyYVl+3bMyas+UXks6Iy2oCiM=;
        b=A163/vQ2x48/idAf+iDMWWGDP/MtYgk0RvrOx9RYMxa55xzpuM0YylKZk4tw5RBS4t
         RtflaD8Z01+XU2fPp5kcI0zMDBkwV2jyioMhu4I2pDhtoSaVMA8pims2wOSMIfgOFgiQ
         7O50YZwi4QiB/J2Tjw/16+UnGX9JXyCBwEGLuYNqZruXDLQ3kYjx8WeF047aas3BYKno
         P0hBbi1FjPsfjilY+MlkFzQXAaXigh0YPMt8CN+6+Czj95v6sFt/Ab35n7ZnOr9VvAyY
         tQPnlUtiCuTplq8ihOCi3x4t9QYVe59unbFia4YSjVoXovMDFPXUG0jHrbgxEq9MCif5
         wfOg==
X-Gm-Message-State: AOJu0Yx04ram35P3lk1hwjGVoCci3X6YzWNSJBtGZH6g61fjx6bpr24x
	idI/Yvdti5cPPSAsGP7kDdW79C8g32WkvrwALf+0l5BaJUrZQ4FPTSejmsJ3nXAXq3UgbLJCACe
	wjLBYgqItPldruUW00kCeTE5i4QlYjXYSzJquSSoUtfxdlpC9gdJwjasx7wJEmkhzVlAxg6EE3k
	I=
X-Gm-Gg: AZuq6aIyYRGvmbehN/GlWmsQfAaNC0o4ol4NtORw+3S1pgbcwDzXa2j/l3MNygjF2CX
	jJ1o8DLhpqxBxrmuTcnl4Mq36LkzdzaN7bdXYBc4QKqFmR5HzgxrWggLAgFWblt7qeXkVYigzYH
	7scC73AY47GrMqeUjJEGKuH4MMUyB2qL2pzVZxKvgX6dIdKxSLDW2U7hJuSbdtJkl9Ks819C2H+
	PqYLV+4CTxGkK/BOKdQ6q9vDlaShSSeh+Jtzch0mZ8R9bhogyh6m/8=
X-Received: by 2002:a05:690e:2545:b0:644:60d9:866c with SMTP id
 956f58d0204a3-64917773dc2mr12075758d50.93.1769089295468; Thu, 22 Jan 2026
 05:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mariappan Ramasamy <mail@nappairam.dev>
Date: Thu, 22 Jan 2026 21:41:23 +0800
X-Gm-Features: AZwV_QiZNeDZM11o-MKk_7KDA7mQ7yo_sasVTb9FNUuUgnOAyzlxMEQbDosuESU
Message-ID: <CAEc-AF7dobeSF+WEvZ0gZ9yS9j-6BS2pj=Ne3XWvW=SqK3558g@mail.gmail.com>
Subject: [PATCH] Please apply 1fb0d830dab8 to 6.18.y
To: stable@vger.kernel.org
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, "ravindra@intel.com" <ravindra@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[nappairam.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_NA(0.00)[nappairam.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,mail.gmail.com:mid];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[mail@nappairam.dev,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-211241-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nappairam.dev:+]
X-Rspamd-Queue-Id: 0D43E6810E
X-Rspamd-Action: no action

Please apply commit 1fb0d830dab89d0dc99bb84a7087b0ceca63d2d8
("Bluetooth: btintel_pcie: Support for S4 (Hibernate)") to the 6.18
stable tree.

This fixes a regression where Intel PCIe Bluetooth devices fail to
work after resuming from S4 hibernation. It blocks S3 sleep after S4
hibernation. The device loses power during hibernate and its firmware
is erased, but the driver doesn't properly reinitialize it on resume.

Steps to reproduce:

1. Suspend works normally before hibernation
2. Hibernate the system (suspend-then-hibernate or manual hibernate)
3. Resume from hibernation
4. Attempt to suspend - fails

Error logs:

Bluetooth: hci0: Timeout (3000 ms) on alive interrupt for D3 entry
btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend
[btintel_pcie] returns -16
btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend returns -16
btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
PM: Some devices failed to suspend, or early wake event detected
systemd-suspend.service: Main process exited, code=exited, status=1/FAILURE

After hibernate resume, the driver also shows restore errors:

btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_restore returns -16
btintel_pcie 0000:00:14.7: PM: failed to restore async: error -16
Bluetooth: hci0: sending frame failed (-62)
Bluetooth: hci0: Opcode 0x0c01 failed: -62

I am experiencing this issue on a ThinkPad X1 Carbon laptop with
NixOS. Hibernation and sleep worked correctly in 6.17.x releases and
broke after upgrading to 6.18.x.

I have reviewed the changes in drivers/bluetooth/btintel_pcie.c,
identified this patch as the fix, applied it to 6.18, and tested it.
Hibernation and sleep work correctly again with this patch applied.

The fix is already in mainline (merged Dec 1, 2025) but has not been
backported to the 6.18 LTS branch.

Upstream commit: 1fb0d830dab89d0dc99bb84a7087b0ceca63d2d8

Tested-by: Mariappan Ramasamy <mail@nappairam.dev>

Thanks,
Mariappan Ramasamy

