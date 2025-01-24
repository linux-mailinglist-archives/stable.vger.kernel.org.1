Return-Path: <stable+bounces-110338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D75A1ADDC
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 01:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A197A2234
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AF0442F;
	Fri, 24 Jan 2025 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ene-kolla.pt header.i=@ene-kolla.pt header.b="KJLRtMR1"
X-Original-To: stable@vger.kernel.org
Received: from ene-kolla.pt (mail.ene-kolla.pt [89.149.207.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910D3C0B
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.149.207.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737677708; cv=none; b=f0UoEb+LkC3Pyi246tRhHG5CODl4aI0TBYvmfr5hLm5Awhwz0N674cpkXsLhdxDvdCNiTMqwfCTdN0h9nr94SWGLQ4iZVqb2/Cr/isQl0Q2+yN+h/m78siTE1tZTindHeXEb/sljYeW4YvtCAZP4cNtNIJ+2AD6BKz2sOnkKlE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737677708; c=relaxed/simple;
	bh=6Cz1RoC77WgRsOJMWY05qhxtkmo/QejZ9PVT55bwtTs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FLuYaiPrlYUJsCy1HE4npZvFhpV8L4vk7GqND8Ma6qyNcSxt2skDJsTN77oISFsxyZxASxvJhIwi/+ZtjDvHGb5voqq3LJLr6ctC8X4fe2rUJosFxxEJ0F60ghsBW0r6iCtITESG2eiciqLGPKKewr4TAFadPv5qsP+3m4CQe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ene-kolla.pt; spf=pass smtp.mailfrom=ene-kolla.pt; dkim=pass (2048-bit key) header.d=ene-kolla.pt header.i=@ene-kolla.pt header.b=KJLRtMR1; arc=none smtp.client-ip=89.149.207.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ene-kolla.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ene-kolla.pt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ene-kolla.pt;
	s=202211; t=1737677698;
	bh=6Cz1RoC77WgRsOJMWY05qhxtkmo/QejZ9PVT55bwtTs=;
	h=Reply-To:From:To:Subject:Date:From;
	b=KJLRtMR1+sBrsm8T62/ElQDr5YhepidcDXOFDEppaWfTT8LfEc9BLlJ9s7SdQtnWO
	 vU9iZcN4ZNC6A6cWhy7a5SCtBuVIsQ4TOhlZ/iYuUwIqbJz9gK3wzrf5tTyRdZJeZm
	 Ljr/xabJRg0Q52VaOzBIXMcGJrQxRSZZddLcLbWGp5NhZlbVIB0i+lg20ItqQW7mR9
	 2xMJRoupHRMzf3RPfqGgW+pcwG5GnXdgWU3OtpER6q0tRMhqhuiR1q8QnyhjEOx2DT
	 PvVzbvqpHjK61DdGLrKEIjEqWTrwZQtD2HDINdXN7b5T/c5EeoSKxRIq9MEFVEnRda
	 cNSB2jzg3bMjw==
Received: from [103.202.55.136] (unknown [103.202.55.136])
	by mail.ene-kolla.pt (Postfix) with ESMTPSA id 7AA95F8D52
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 00:14:58 +0000 (UTC)
Reply-To: wioleta.raimer@invpolamd.com
From: manuel.rodrigues@ene-kolla.pt
To: stable@vger.kernel.org
Subject: urgent request for a quote
Date: 24 Jan 2025 01:14:57 +0100
Message-ID: <20250124011457.618CCD98FC3AE978@ene-kolla.pt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,
My name is wioleta. we would like to know if you export to=20
Poland, as We have active
projects that require most products as seen on your website. If
yes, please kindly keep us informed upon your feedback so we can
send our preferred listing for quote. For further information or
have any questions, please do not hesitate to write us.
=20
Sten Arnlund
Purchase Manager
wioleta.raimer@invpolamd.com
a: Vedwalterdige by 2, Holmerskulle, 432 68 Poland.

