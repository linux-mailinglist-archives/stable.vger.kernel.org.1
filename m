Return-Path: <stable+bounces-79525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8069E98D8EB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2489FB24576
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A571D1502;
	Wed,  2 Oct 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gRFI5tuo"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470391D130C
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877712; cv=none; b=uMyU4o9r76qXLEo8JMbX7Y20EoroksvwGlsUdiKDAsgY63M8/+9cWIvpz0GELah+0qZqj0oYgNKHAYGkjf0phrwYz0nrqQzQ3nkJzZM+pnI1C9TfTygF9a3BUgiXjF3ydfSUqhJ4cS4p73Z2NEiUSwG4S46p7+K6DC87gAfvZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877712; c=relaxed/simple;
	bh=2GRoC076i+LR9S4VmtjSZKIKxNF7++4V1Y9CdSzogXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IF0ZfKpe2/gKRRvTTzQCTQQToxV7X9WAPO626RaHNyX0bz7sqXSbfgjwTMV0NZkHSfcxv11P2E+42L/qj8aHNvOZHvEdE929f07KuyjP0AlHw191PNGmK3szquD69KQkz5C/HGx5FMSQPUDWr96N3gAQWw/BXdnpXQE31LEUc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gRFI5tuo; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3dd9m3pu3yhliBaGh4iPeGCL+uzRN28XMu8plS/NWOg=; b=gRFI5tuoIeJbe8lURcDXblkCKv
	v5MD9FrrSrV5fqDoNUH/zax+f+/u175+4Ua7IBeyZt4dFuqZkGAm8AFSu4191YB5tMWAjUOwxs7ij
	Jk6RVPWrAv7KKB0hqyCDqhhpn+GDImf90XJJN7xcxVgitmBPqdDaKZwrRnKCHa44B/3uWmQnbOL+t
	1CgGYBYBQw9HKzye9YYh1AWaQ6e3CjvL3T7oot+8suTe2Jb9dfBGqM2mpql/mCcwe5ZkIRxqVnpDM
	nBJgPDkHOyxtdwaR2e2NHJUAAbLvbsqzQFHncXAwYtMaTvuqMCuVggl1eVDmVcYcE1DPZ0PbTuyWr
	9UaiyhUQ==;
Received: from 179-125-71-238-dinamico.pombonet.net.br ([179.125.71.238] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1svzvB-003tUy-NQ; Wed, 02 Oct 2024 16:01:42 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christoph Hellwig <hch@infradead.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	kernel-dev@igalia.com
Subject: [PATCH 5.15,6.1 0/3] Fix block integrity violation of kobject rules
Date: Wed,  2 Oct 2024 11:01:19 -0300
Message-Id: <20241002140123.2311471-1-cascardo@igalia.com>
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


