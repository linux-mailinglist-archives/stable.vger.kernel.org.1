Return-Path: <stable+bounces-83069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C69954F2
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D06C1C25F3B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8C21E1A07;
	Tue,  8 Oct 2024 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P9N6c0DV"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5E1E104C
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406324; cv=none; b=iIjc/2RKrKgAeBEo8if0W7TWEWu8wKcWfXaGT1hgjPAt9oflpjB2ZJNjZ+tcOcmoi3ppZUJvcZ2NBlvh26+0qyVQj0/qzkH3qfNfZ+ZIP0Fv2ZKAaTzJlDheue+15zDhg+yppaJKJZ25yJRX5ZERnb3886a0iAmvR6OZZ3F7SjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406324; c=relaxed/simple;
	bh=2GRoC076i+LR9S4VmtjSZKIKxNF7++4V1Y9CdSzogXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jIQitNLUlS5Ax5bWwgU8COLP/zjNblK1HhXDjEr0gOc/3Qezw0wG8tNhGQcSJ2HRtRFxI12RPFnW7ac5sAc4lKztXjxvq0IgULtuuTJDB0QC1HhQF08Sa8MZOgfoidBGFp+lgiur3YpOr0ENe/uLfwjuW3Vz8tupA0fw0wgRlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P9N6c0DV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3dd9m3pu3yhliBaGh4iPeGCL+uzRN28XMu8plS/NWOg=; b=P9N6c0DVWfwfU4reaB716xXNOK
	ndhT7sbpb29Ftj9HfE8/5xP9d+l9ums+d34pfXDoWJ4x+l8rE031zB/nosw4o4eHXn08e6Q9bFGMI
	dRuxuPWyyQxRKKkerYQ6gFmUcYL67L+nH9CXzxQJlBilZ9LvNwoYjmVWnTPB0FktJMPgbo6C8CoOD
	6kf60RkAerN1zX2RDVgIwWZ4mumWg1SDH5dvW/RU6pyYhXwzZiwpKp0wPu0mn4zdHckWc3WR2u74t
	nsGOCNWR+YVPAMrl3Avp7zznAV/BgXi0oZm3soIGgJezhvO9Ks6Ax79ZtJXRrP92H/7s+ElimVL8f
	fauN9muQ==;
Received: from 179-125-64-236-dinamico.pombonet.net.br ([179.125.64.236] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syDRC-006dqX-6K; Tue, 08 Oct 2024 18:51:54 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christoph Hellwig <hch@infradead.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	kernel-dev@igalia.com
Subject: [PATCH 6.1 0/3] Fix block integrity violation of kobject rules
Date: Tue,  8 Oct 2024 13:51:42 -0300
Message-Id: <20241008165145.4170229-1-cascardo@igalia.com>
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

