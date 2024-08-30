Return-Path: <stable+bounces-71649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C99662BD
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A052818BE
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F58516D324;
	Fri, 30 Aug 2024 13:16:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63D1DA26
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023762; cv=none; b=SBbL9UxLjrNvWDXZ/iuDytfLQrfr+KUHTHi2xnM4qOOSHPLsnf+eErab8p2X9eDXi7YvXMEJwjDbNaT60sIPEgG/cWPqMGDwyBY79cAcJIWd3PiTKJKzjA/nEj9K2DPjVWZPsAc2sPxVMj+Ky0xOV8pYWmg7T9prquUv4kMHbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023762; c=relaxed/simple;
	bh=M8zrPvrEr+Ep7F4wBYFtCyPOGuD/yvxwT7ILUT2dt98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+M0blgV9iVa6j3uzXuAvJuG4SRQjZxCktRQ5FCLTMUcooyCEJ17Lm4K7bynmKKfLMJX4X96oSybqMpHq7V2LMGLw4LeR41z4dxmQ6ZKM8GwRaEScQrL5iIS5PIcSleENM7eC6w5CVQkzR8HmI8eGvkKmGI0g73GAhAjvrarXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 739F52F20226; Fri, 30 Aug 2024 13:15:56 +0000 (UTC)
X-Spam-Level: 
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 4A19F2F20226;
	Fri, 30 Aug 2024 13:15:56 +0000 (UTC)
From: gerben@altlinux.org
To: gerben@altlinux.org
Cc: dutyrok@altlinux.org,
	gregkh@linuxfoundation.org,
	kovalev@altlinux.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.10/5.15] net:rds: Fix possible deadlock in rds_message_put
Date: Fri, 30 Aug 2024 16:15:56 +0300
Message-ID: <20240830131556.61627-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
In-Reply-To: <20240830120635.59682-1-gerben@altlinux.org>
References: <20240830120635.59682-1-gerben@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has already been included in the 6.1.y review cycle. https://lore.kernel.org/all/20240827143840.483413365@linuxfoundation.org/

