Return-Path: <stable+bounces-159246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE84AF5B0C
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 16:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E74188E2E0
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55352F531B;
	Wed,  2 Jul 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="BIDfhzn7"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E02777F9;
	Wed,  2 Jul 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466281; cv=none; b=Ym/HwF9F36IU4wTou+fctiryjC2u49QjTh5Uxm1W0GedSSU2rTaSbnjeD6dl2armRI+shaipY+hUCcYlaUASY7wacOSRALjVVOvV7LUkTINpVXBtwNv0tDCFWMtZXE5A7IYn6DvxRxvRZDc59O6ZylC8soVLAvKMQJjBJwQXJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466281; c=relaxed/simple;
	bh=0+7L8fLqxJb5AyBlaDa9ZfMehG8UnncNNNdr1XfhJVE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fZiuwpiKAVCF1LH3lpSvO6B9SGN3M0fPtZQSmX9OM6klh1jl/vMVXENdiGWSPvCGlUH9pdEGr5j6vCLxHOMEpHP4QzW6TxDQvT6o27VQtN7krKAgAkiqB2i7MKUU0rxpvx9toioclPXr6ZZG6r17kwTVzhu+eZtV5K+P9COjFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=BIDfhzn7; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1751465886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3DUlpEKsACdnEXHsOcxPwAOx0thj+lv6oLlBcLccapE=;
	b=BIDfhzn7UF3CAdBEovt72UXOSTeypWWh2yQa562b4ZHzNkDjKq/T9yU+FNzXhFEN7Bgew8
	FUf8YsInFtymQUc3uWjAq9s69dAp/AwEk1sTBuM1mNVq5+3s89AUFaivl0z7k5kd3uIOGZ
	a47fd0RryZwQE5ipJWzOXLeje504zpgWOW76MT0TBd26VN5IOdcNeE2n+g9X5IPGdKFClJ
	J/QkBC2cslA3HjKQCe9wJ36NsQx/pANgV7LvzB57NZWIo0djtoJsEBpONvUi8SYNlF9G5U
	vcyDwVqci08hIILEQbqvV2XWtq5ex5Eowc53dx0I6F+mOfCuPSNTDi7FavslEg==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Subject: [PATCH 0/2] vt: Miscellaneous fixes for keyboard input handling
Date: Wed, 02 Jul 2025 21:17:56 +0700
Message-Id: <20250702-vt-misc-unicode-fixes-v1-0-c27e143cc2eb@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJQ/ZWgC/x3LQQqAIBBA0avErBswwYSuEi1Kx5pFGk5FIN09a
 fn4/AJCmUlgaApkulk4xYqubcBtc1wJ2VeDVtooqzTeJ+4sDq/ILnnCwA8J2sV1wdtglO6hvke
 mP9R1nN73AzELqfVnAAAA
X-Change-ID: 20250702-vt-misc-unicode-fixes-7bc1fd7f5026
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Arthur Taylor <art@ified.ca>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>, stable@vger.kernel.org
X-Spamd-Bar: ---

This patch series fixes two long standing bugs that when combined
results in a ^@ (NUL) sequence being generated on the virtual terminal
even when the keyboard mode is set to OFF every suspend/resume cycle
on ACPI systems.

Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
---
Myrrh Periwinkle (2):
      vt: keyboard: Don't process Unicode characters in K_OFF mode
      vt: defkeymap: Map keycodes above 127 to K_HOLE

 drivers/tty/vt/defkeymap.c_shipped | 112 +++++++++++++++++++++++++++++++++++++
 drivers/tty/vt/keyboard.c          |   2 +-
 2 files changed, 113 insertions(+), 1 deletion(-)
---
base-commit: 66701750d5565c574af42bef0b789ce0203e3071
change-id: 20250702-vt-misc-unicode-fixes-7bc1fd7f5026

Best regards,
-- 
Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>


