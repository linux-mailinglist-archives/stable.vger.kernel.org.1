Return-Path: <stable+bounces-114329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1548A2D0FA
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957A016D665
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4131C6FE6;
	Fri,  7 Feb 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnoOOyup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369E1AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968667; cv=none; b=ZSq87eeq/3S2yDyuNkAqqpw5b9QdirYchumdk6b3bz+h9l50wI0qJ/reZD95++KnHD/HMSex8ElvrYLbVD4veN6KypwXk99+hxSBWnrUR01dLCd0xN94cBllDWgssHFDCRhCenizcgGqdB9B4UjupGT3cxeOo3k2R+nAlrD1O8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968667; c=relaxed/simple;
	bh=6vr/YbnaCoMjj5+tlXmCNPLf9kb9jFysnR0uaWQsSsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfjuQLylwPw3+nBBJxvbIggdUcxhVOYk78Rt1WCRILFalyjF+n0Rn+DP3ZIaXdYA1x8L75hAN2+HAgwvB4Gt62sEo68MYLmHI21WAzXDSseofSWzc6szh7+lmM4/pv1PUjLunQYGEm7by2IyWfOEKFc1RDkZDZUAdCaEFHHrgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnoOOyup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543C1C4CED1;
	Fri,  7 Feb 2025 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968666;
	bh=6vr/YbnaCoMjj5+tlXmCNPLf9kb9jFysnR0uaWQsSsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnoOOyuppKXl9rupslDzWOZx/uNDTWd5nktehhcB0XOo+Aoa8+NXrqChtD8U7b4EF
	 S41yXb6rEBnmQjLUksDcaEgLAACVIg7KDypfncZ/30cy5EXwW0qw+aGWkHDaEUZgrH
	 82QCOjMlagYDQ7AJW9sVTJz1ADw+J7cbSVo4Paz0iU6gOgR9zo9BOPOnkUm9fgB68o
	 mBH+csD6AjonTGx/IGsRrbGFs2PcIgezEiCMdmy8v5Mac8kCky0t9VHVb48MQ5PIy2
	 pr0XGsKXtVeZOo656wBRgU7v/+18cMeBr2nvOas1GnsLqwAcY5rzznf/ifCs6ai3T7
	 U9R/M4/eOb/Qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <koichiro.den@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 17:51:05 -0500
Message-Id: <20250207165636-43d03b4f65f824c5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250206162023.1387093-1-koichiro.den@canonical.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.15.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

