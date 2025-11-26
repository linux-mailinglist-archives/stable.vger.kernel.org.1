Return-Path: <stable+bounces-197013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538F2C89C28
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E44E3AF20C
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE6D32721F;
	Wed, 26 Nov 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtvWhCaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64272ED853
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160149; cv=none; b=sIj4jpZQbfupc+0hyeRJL+DAOSy0jjKPTcBtO3YwVkZ+gHJTOyvBaNHNUgFybqJ9VYYvcorvDVDqpYaKTkIKSqjwIfuA08oCWxeAn1PN847ztfA94pfQue0rE6RQFJohCGIsh7siX61/5X3r4C+VBNKjhmgo9fwpzFRCdbjSUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160149; c=relaxed/simple;
	bh=CKcZrr//GSGV6JnBqSNXANK4/wk9MhH3yZ/69p81e84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDXDRYpzULqCTAauiFhTyS+4PRFJegED/D4S4Mn+luScIlf8VHbIoM9kBoM0WzmvgRWwJTssoh9G2vEQ/YxK2J+x/F3ARjF8kkxLOb1hDoC0Cr1hQIj4M8QUaqz1RKVN4BcwuViLpHWqt/Mvv/+DXVN2cP8C4sIaWDn2aCBzBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtvWhCaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78745C113D0;
	Wed, 26 Nov 2025 12:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764160149;
	bh=CKcZrr//GSGV6JnBqSNXANK4/wk9MhH3yZ/69p81e84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtvWhCaNZj36CPs3hL7SoUuE6awotH30YMIqgu8f3U5vsqrDEnbnncknXj1kpQueh
	 EdiW+2hO75vDdgDGWjdOcZoJBZSfiw8LEys9svn61st2VwTKADl41aFQtmenlIC4u/
	 mI5N+70hjy6VjxM74T28JpT+BG6K6QbgyVZC0LQrzLo89nXSZiUPqOavIcOzUwz3Hy
	 z+fJqkn0897vdrLwgzfC3rZzuoHIE4o9C51PuLXYP+cSaLCy4Ovo2598EH5KcPKy+W
	 uE5pI+1MyVGD7yrPVmhGyKMbat+G4JD8GLjGR0m01TDE7wzxvpzKnFdEqbF0YKGBFg
	 l9eqQLzzjectQ==
From: Sasha Levin <sashal@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: stable@vger.kernel.org,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH 6.6.y] s390/mm: Fix __ptep_rdp() inline assembly
Date: Wed, 26 Nov 2025 07:29:07 -0500
Message-ID: <20251126122907.1363827-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125105107.1067952-1-hca@linux.ibm.com>
References: <20251125105107.1067952-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.6 stable tree.

Subject: s390/mm: Fix __ptep_rdp() inline assembly
Queue: 6.6

Thanks for the backport!

