Return-Path: <stable+bounces-45202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F468C6B31
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886DD1F21A38
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BEF3BBF7;
	Wed, 15 May 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aU5TQtkS"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0238F97;
	Wed, 15 May 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792559; cv=none; b=Ni88AqsCkTiRTq9fFYG62TdDoHJJRT1T1jNvlythKOC6KkE/IURx5kyWLES7MK2y5P7aI/uJ1kf4m+qibu0beb/uTVjjRpygrx4ucmRssAJvhErITK0H3iqs6vOnMXO7HwTswTkXU/sEHWqoG6OzTvJ0ib/KfMI7GwY+1lGiqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792559; c=relaxed/simple;
	bh=sh6dC9SOukvi7MPoaikcDxiQDqmDjj4j2RtoXAoSvd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBwy09jlsvrC5RK1qnaEULtVx5Yp9vd2D7lO2uph2ISJBn5NLxSWDkb2kSqvxBjh03VhL0gmKZl2ykiJWGZCJg/+wuuZIxC0e2IKPkW5qejFkSd8NB0kVYzEsoAZV8rNmpFnJNVdn01ntaTnshaTNqcjJV/ve0np536EGrGdxEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aU5TQtkS; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 08C93C0000EC;
	Wed, 15 May 2024 10:02:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 08C93C0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715792551;
	bh=sh6dC9SOukvi7MPoaikcDxiQDqmDjj4j2RtoXAoSvd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aU5TQtkS0yZE/oN39zx6JAizlSRmLyRowuy0Dcc0r01SL9lLtyQXEc7T8BwMY8Omo
	 jnAMXgIi0u6+ez18YBXtaCYoqU7bTXYbO57WitPsPOLZ+YuAp7zEQGRMuW5bDBKqrr
	 HjH6Ah4TkhSVssWgb2C6Ilj8OxeCIssi2zYBMvp8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 00CFD18041CAC4;
	Wed, 15 May 2024 10:02:28 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: broonie@kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:BROADCOM GENET ETHERNET DRIVER),
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH stable 6.1 0/4] GENET stable patches for 6.1
Date: Wed, 15 May 2024 10:02:23 -0700
Message-Id: <20240515170227.1679927-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d52e7e4a-2b60-4fdf-9006-12528a91dabf@broadcom.com>
References: <d52e7e4a-2b60-4fdf-9006-12528a91dabf@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This brings in a preliminary patch ("net: bcmgenet: Clear RGMII_LINK
upon link down") to make sure that ("net: bcmgenet: synchronize
EXT_RGMII_OOB_CTRL access") applies to the correct context.

Doug Berger (3):
  net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
  net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
  net: bcmgenet: synchronize UMAC_CMD access

Florian Fainelli (1):
  net: bcmgenet: Clear RGMII_LINK upon link down

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 16 ++++++++++--
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  4 ++-
 .../ethernet/broadcom/genet/bcmgenet_wol.c    |  8 +++++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c  | 25 ++++++++++++++-----
 4 files changed, 43 insertions(+), 10 deletions(-)

-- 
2.34.1


