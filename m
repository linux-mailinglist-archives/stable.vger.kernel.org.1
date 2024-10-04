Return-Path: <stable+bounces-81144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7719912D0
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 01:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E061F23FA5
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 23:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B114E2CD;
	Fri,  4 Oct 2024 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b="dOHf5NSm";
	dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b="ewQmsIZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.aaront.org (smtp-out1.aaront.org [52.0.59.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66614231C9E;
	Fri,  4 Oct 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.0.59.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083480; cv=none; b=kyvf2Y697QVjgxv1mqtBN8ftp0iWHhSkCFFl6AuGTdj5vKaukqXNCueQHIDwmnDv5j/C8sEwjBBRB+NwuAi68gFL/yRh+igq2TlmfMutcS3fQ+wjqhBAzse88QnOy7iKTQCBXKiFxxJFmzM2UcEirpgoPK8ZR4iG6YYNWe3SwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083480; c=relaxed/simple;
	bh=KMN2c8hGsw5EmHaZU5+5NqKiYLs6SadoVbNXHeAHjKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qEQJNEba5B6KnELegzgnedLRgiIxZ/kCt+XDxVIBgNMfNgcBdgjs9Udy/4ELQAPAWtaQFQYjRo1uovZ1mjHP2mMHv30Eq+oHf/K8KdkZKVjeTpa3codYGdAKRpUA1pXswzcwYAMmbVrZtA6dCw8VdKECVSb/aXcJOw9lkOB4Ja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org; spf=pass smtp.mailfrom=aaront.org; dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b=dOHf5NSm; dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b=ewQmsIZs; arc=none smtp.client-ip=52.0.59.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaront.org
Received: by smtp-out1.aaront.org (Postfix) with ESMTP id 4XL3z22L4rzMc;
	Fri,  4 Oct 2024 23:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=aaront.org;
    h=from:to:cc:subject:date:message-id:mime-version
    :content-transfer-encoding; s=habm2wya2ukbsdan; bh=KMN2c8hGsw5Em
    HaZU5+5NqKiYLs6SadoVbNXHeAHjKQ=; b=dOHf5NSmuN1Vo1pAFlr68h+nRtBtR
    9lsOHeTOXWJkIr+FbXuQyR2lXM8+U4uZoiKCu90aucwIlGVYPZhQy9fCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:mime-version
    :content-transfer-encoding; s=qkjur4vrxk6kmqfk; bh=KMN2c8hGsw5Em
    HaZU5+5NqKiYLs6SadoVbNXHeAHjKQ=; b=ewQmsIZsBZNTXh4N5MB7vWxLvM/5W
    nMft3iUcw2gOhpZqg811vKWm8N+6WWVNaqEg9Pts960L9fWr2umxSCo3Oo2xveHU
    PiWLJpGss8rII90cp2TXvq1dZOp8apKD8fVbj6NwZr//KRAgktxc+ipS8VvSWwYk
    1dv8Li01aRPqw8cJVXWFnDmT/GMMQQeVQGEFqvTIffYWlm/iQcsExMTVpjVq8s0a
    jyw5Tfq6AjMsHX5MT/VxtPfYfD6HgEljCdJ/9j9DLDxUxeHFYSlUuIQBgjVkXo55
    CYZCUM0n+RZFYvm6XkYtUCGaMSHdynRRN+VQRaR2Csq+Eg4g9/8h/IJNw==
From: Aaron Thompson <dev@aaront.org>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Aaron Thompson <dev@aaront.org>
Subject: [PATCH v2 0/3] Bluetooth: Fix a few module init/deinit bugs
Date: Fri,  4 Oct 2024 23:04:07 +0000
Message-Id: <20241004230410.299824-1-dev@aaront.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

These patches fix a few bugs in init and deinit for the bluetooth
module. I ran into the first one when I started running a kernel with
debugfs disabled on my laptop, and I ran into the next two when I was
working on the fix for the first one.

v2:
  * Move iso_exit() call to bt_exit() (Luiz Augusto von Dentz)

Aaron Thompson (3):
  Bluetooth: ISO: Fix multiple init when debugfs is disabled
  Bluetooth: Call iso_exit() on module unload
  Bluetooth: Remove debugfs directory on module init failure

 net/bluetooth/af_bluetooth.c | 3 +++
 net/bluetooth/iso.c          | 6 +-----
 2 files changed, 4 insertions(+), 5 deletions(-)


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.39.5


