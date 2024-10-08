Return-Path: <stable+bounces-83073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FDA995512
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 18:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6660B1C24A18
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09C1E0E0D;
	Tue,  8 Oct 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rz0zGuSG"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB11E0DF9
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406398; cv=none; b=dU89Q/qe0p3jpNI8IW7hK47BEXMBYi19vZOk0Cm7G6RkGaz2yFgxuos94f57/yzFKYxAkITcrTgBEfDc235ZkxmFv90LeFVF5v+GUpADVpmcloqe2MzGjMzLf5gM5nwqqg23W0+UcGcZa0cwJ6YVPCIoRDladtGWHY2oPgrqIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406398; c=relaxed/simple;
	bh=2GRoC076i+LR9S4VmtjSZKIKxNF7++4V1Y9CdSzogXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iDRmtXRQeF1DEEPqN5LDl+8NlH+7HQvsItzqEjeG4C9S0UP7n6qSjJmfovq9rDs92TD5DJHs22WdeMwNZZ+qnRy5l/YhBGN2G95eXOdDiwfWv0W2+QfG4aAnbhAA0DAer6iWVpn9BQbMAUvPd14HWxWIgROMbnW4XsOOaAEViGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rz0zGuSG; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3dd9m3pu3yhliBaGh4iPeGCL+uzRN28XMu8plS/NWOg=; b=rz0zGuSGM1OTN0r2aJ/uvbJZL/
	W/QIQsmPWo142dJOUo8TyC1zGX2ut6Jg8P1WHALR9tbwmy1+9W5/QrSUAAM93YI3OiJDW+fDpTGEU
	CyoBMB7FZyT0Cchzs7tMz2uKeeoDduYIcjhrojA3SQMbU3rQckYLdIr6wKKNtviKgoCEralnBOqfh
	TArlKKcYtz/8iNgplgJdgc+IfCeP/oblBPzviI8vFIynCxa1BH+lW9keBqMvHBy0zdnqmM3uNi0FI
	Sy2HNmalHY7Sje0+HljS6VsNYQvGbwEQWiEpTsu2T00VQpU7yfDmbV8MOWgnaI6KTZ1uTm7dVNU0j
	dcUIJ0pQ==;
Received: from 179-125-64-236-dinamico.pombonet.net.br ([179.125.64.236] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syDSU-006dsM-2F; Tue, 08 Oct 2024 18:53:14 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christoph Hellwig <hch@infradead.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	kernel-dev@igalia.com
Subject: [PATCH 5.15 0/3] Fix block integrity violation of kobject rules
Date: Tue,  8 Oct 2024 13:53:04 -0300
Message-Id: <20241008165307.4170334-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

integrity_kobj did not have a release function and with
CONFIG_DEBUG_KOBJECT_RELEASE, a use-after-free would be triggered as its
holding struct gendisk would be freed without relying on its refcount.

Thomas Weißschuh (3):
  blk-integrity: use sysfs_emit
  blk-integrity: convert to struct device_attribute
  blk-integrity: register sysfs attributes on struct device

 block/blk-integrity.c  | 175 ++++++++++++++---------------------------
 block/blk.h            |  10 +--
 block/genhd.c          |  12 +--
 include/linux/blkdev.h |   3 -
 4 files changed, 66 insertions(+), 134 deletions(-)

-- 
2.34.1

