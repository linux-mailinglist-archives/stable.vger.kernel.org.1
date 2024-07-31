Return-Path: <stable+bounces-64744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC6942BA9
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 12:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961151F21A21
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8991AAE22;
	Wed, 31 Jul 2024 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlFX3dEj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987C208A4;
	Wed, 31 Jul 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420635; cv=none; b=A8b6DYnCXmD5mIh2+m6QBiXJcKaBHK1UqpllpD3HhkkoXAfoERFWIR01mMTNQh+5geC9GbRCFn9EIEAolXU7XoLVDIf0V9G+1cBQFKOy8k66XA6KMSsX5QwCI9feSi4TDI9PlALxEZ9v3akNHqrYlx4epzk+oXrw+Zz+lb0eiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420635; c=relaxed/simple;
	bh=vD1VnMvl2NRzkDty/gTCCol7xAn57MKJEdZaZUfDLCs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oerTtpXoJIApn0E/CZ0LC0EScbiXs7aq74Nm1muUj5zx5V4JVDFo9yTvLKuWgehLXpHKg+vdy8U45qHFyB9B59LisF1NP7kMZVOimQg5SSFpIOMULFgGy7rQZwGP3BgUHZ32oXr/fc+uRkpDuMR1EVUhodntDahT8REY7F1530k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlFX3dEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4FAC116B1;
	Wed, 31 Jul 2024 10:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722420635;
	bh=vD1VnMvl2NRzkDty/gTCCol7xAn57MKJEdZaZUfDLCs=;
	h=From:Subject:Date:To:Cc:From;
	b=LlFX3dEjmxM2f2H6bgSj/tTiBEcFjUpcQzLkZdqQ7RleuTQpgRRaEEjAJ78mea1Nf
	 D7ux9lhYSKagBZ6ff8RFo3JISyPXBB4tww9QP30TTu4avySOMSicoRKIOCy2X/+BBf
	 xntDn64TiVnk4ZRp+rTiZDKkKFu7sBjRMsCaxxS7LyThgBKoZsloyZQSLLBgVzHa1f
	 JmEU8IYeGtvb8cLQKdjTlcjSjZPeXrywAIC1xPkSi5I1SfR8YeYeY0BAOlHf4EVPEd
	 KB2wxnDjbs2bAQxd++CEewKomg4IGOZt3PzJC1qBMvnLUMKCPHz/sEubJSV0XnJsgO
	 SmiA91477rg9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] mptcp: fix duplicate data handling
Date: Wed, 31 Jul 2024 12:10:13 +0200
Message-Id: <20240731-upstream-net-20240731-mptcp-dup-data-v1-0-bde833fa628a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIUNqmYC/z2NzQqDMBCEX0X23IX8WMS+SulhiZu6B2NIogjiu
 3fpwcMcvoFv5oTKRbjCqzuh8C5V1qRgHx2EmdKXUSZlcMb1ZvAWt1xbYVowccO7XXILGadNQ40
 wjs75p7feUASdyoWjHP+bN6gIn+v6ARdPPEt7AAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=842; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vD1VnMvl2NRzkDty/gTCCol7xAn57MKJEdZaZUfDLCs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqg2Y+KFMRCGlUMnM2D8COJX+RkntbwSfSxUyV
 bfFkBkd+PyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoNmAAKCRD2t4JPQmmg
 c0zBD/40qDCSNg/LA1kh10/uJb/pshttebE9H34JB+CSKvRjq33SklLK9+AunMOGnUbSeKSniA6
 vC4kH3728X80tgNlEcAsnMs2sMaczHbZY5cpcxe7D70mXO+l+VlcY3YdY4Q2EAS/uR/QXITePae
 yh9fpufuztm0ZUnfpLiRyFLmr3a/ymanQRoZGy3MMRzKI9ulax4kwm6F+7TvOu38D6I8SWDHH73
 3Gty0/t0/Qo5tswplfHCcVnac0d4hdhPSs/kJaNJ0fsAw4G3gt1LqIfI/EfEO3vSdjfIJK96hL3
 Lp3F/4zzQyRY24uDoc84ainciBMaJUh+s8DpfjAEDmF3XkREWOnDjoc1X6R7T6+9cs9CGTJrKQm
 Xt2sYhPJIjPEJzMYjDS6uKQtE6PIVQfFkUc1Xo51yx0xdXJ/7lwsclSJpGKXUhRTKXnVtPfLeLW
 JF4yuHEeq31Mv0EnebkXM7zpaIPttZqx+Zxy5FVHNKVNJuZSpKE060MgfCSFxVFwrH/FCqpNLsS
 bwte5N93dx1FT44GCs+O1NFq5Za+wyDVaP6gq9Cs4OEzCYgeALoNsO9rAObueIgZZEmFW6NyO34
 qqqk0OB+74YvQLip6Ie08Qd5ynI5rxL1fpC7kpUFqyqz98Fmj/TldaxuZMQMQp9uhjIdcH/QZ1I
 OXhMlY7dhB8NcqQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In some cases, the subflow-level's copied_seq counter was incorrectly
increased, leading to an unexpected subflow reset.

Patch 1/2 fixes the RCVPRUNED MIB counter that was attached to the wrong
event since its introduction in v5.14, backported to v5.11.

Patch 2/2 fixes the copied_seq counter issues, is present since v5.10.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (2):
      mptcp: fix bad RCVPRUNED mib accounting
      mptcp: fix duplicate data handling

 net/mptcp/protocol.c |  8 ++++----
 net/mptcp/subflow.c  | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)
---
base-commit: 0bf50cead4c4710d9f704778c32ab8af47ddf070
change-id: 20240731-upstream-net-20240731-mptcp-dup-data-f922353130af

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


