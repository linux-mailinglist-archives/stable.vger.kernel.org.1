Return-Path: <stable+bounces-99982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A99E77EE
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 19:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98683285B85
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3ED1F3D37;
	Fri,  6 Dec 2024 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+EKmxYX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5E5195FF0;
	Fri,  6 Dec 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508989; cv=none; b=hqXYLdFDzhxYibvsFq1CeDQ/q+nzUMuaQwyEvw4lUGnRlvmlSCtnkB5TSxKFcIG9UapnXKDKbim3BEwN+qPZsE03M3ImQfK4I55owvTsAPTqXiQveaEo+ksPxMTNCG2e3x006YIx36fJHtMW/jyOgzoWOwZg+/+whlG1/aZeI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508989; c=relaxed/simple;
	bh=TP8jtpInIa7f7Q2pH1WcPmb4nqDQ8pAGgA2nYlbrhOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHJtDNBMo2NG6mhcXKFYNKTxjD9aaRhLjoQsIjQxTZAW/PRZ1jqWy9yqARRrvlzbJPl2t+MUtrT6EAUoqUr6Z8cxZtQ52XbZfrPdkPd9KSusAKGwi03/rkJin/BnS/owFDDkMWav49ctTYY7Sn3knshxG/g0XAZlfP3sXoolI5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+EKmxYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8DCC4CED1;
	Fri,  6 Dec 2024 18:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733508989;
	bh=TP8jtpInIa7f7Q2pH1WcPmb4nqDQ8pAGgA2nYlbrhOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+EKmxYXcC2h2G75WEc8VQRt/aCpVRslNvdus5Zfet6kSW57a0I2kyIc6WERgjaN2
	 9iNROoIWbnP4bFmdoGvVJjjQ5yAx9SHeKANFKKP2630mnQBkNuSnsl9xknkRY6oZe5
	 Os//hF8lPvcJTUpBEnNwUCwzZw2XvJIdOkZ1y+48XCkYfuurKIA3a2nPDspcSG7He3
	 9SAj8C6sGkrgnQp+LjIcKJyhAGcnmQdtO/pXYW3/Sw7JrZzkmKC/5gnFXxRf9NYrCo
	 IHFAi0+1sUvXhKJ2XH/DK+AcjgWmpDjw368wxNdBxOFafQyrti2nBUOjxUOxpYP0vL
	 8qDfnxIVQjFOQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 5.15.y 0/2] fix issue in damon_va_evenly_split_region()
Date: Fri,  6 Dec 2024 10:16:18 -0800
Message-Id: <20241206181620.91603-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2024120625-recycling-till-0cca@gregkh>
References: <2024120625-recycling-till-0cca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fix depends on 044cd9750fe0 ("mm/damon/vaddr-test: split a test
function having >1024 bytes frame size"), which is not on 5.15.y tree.
Even after applying it, the fix might not cleanly cherry-picked due to
the file path change that seems not automatically detected on every
setup[1].  Since my setup somehow automatically detects the file path
change and do cherry-pick cleanly, posting both patches to avoid
unnecessary delay.

[1] https://lore.kernel.org/20241206173426.75223-1-sj@kernel.org

SeongJae Park (1):
  mm/damon/vaddr-test: split a test function having >1024 bytes frame
    size

Zheng Yejian (1):
  mm/damon/vaddr: fix issue in damon_va_evenly_split_region()

 mm/damon/vaddr-test.h | 78 +++++++++++++++++++++++--------------------
 mm/damon/vaddr.c      |  4 +--
 2 files changed, 43 insertions(+), 39 deletions(-)

-- 
2.39.5


