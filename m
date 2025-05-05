Return-Path: <stable+bounces-139710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2346FAA970F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA1B7A28B8
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E3D25CC62;
	Mon,  5 May 2025 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qubNY4ks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE515574E
	for <stable@vger.kernel.org>; Mon,  5 May 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458033; cv=none; b=oYh8JFSorMLqFboe9lN5TcIzbJMx4AvFu3OECKvAArGzzAMGstmmGmnT5fQFf0IoVfHV3izdCP9XrfrdzeaS6LqC35i9JfIPXq/Xf8FyOQ6Lv/kOsd63TRDbpRAMToa6fMc/ikQI+hu/mIlgOrmd8ULHivODlvw8Yy/FMUyKwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458033; c=relaxed/simple;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwmPRNDzarfcwnANxw2mAmneEn2hhFsNTYks+Zxg8GQCYS1lmPxHXwcctzdXeT5C/rT5A06gRZNpQjwcGZ7oVkhktCxo84hvISq9/cGwvgGC45GO0V0AYZilIXBLQ3Nue7T3M/AaoyimPsWLXXtNvtAyYz31BID3jfzqKViZg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qubNY4ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D39C4CEF2;
	Mon,  5 May 2025 15:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746458032;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qubNY4ksr7vXuSyVWHaFhMNxtyblaMfaYYcoH+dIZrDlTRUlnSm+/e37U4tmY5L2F
	 N1sMjB+4GsVGdtOFqnVX3zo9NOzBHnrgY4LsHPnn9G5qLbO4UBjGUolNs65gOjDa4E
	 2jqci3GRDGFjHHjZGF/jstajY6mfTTDr2UHmuJBgnJX5BXi6sbSD01nRQz3StvAOAx
	 vuS/mY8fZ3Q6OYwI5Jo8kVYI+KKbT7UDiugR2xiKEx41nwhbjCeE+Yhh5S2GxOVbFy
	 6gfjB3qQulTq9KFfK+EotrqY+ffs5d/CPFHEgi8ZVC79k5SZwOP64rDB5gZWSl7z/9
	 ZG8oRj1F13PVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	xry111@xry111.site
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] bpf: Fix BPF_INTERNAL namespace import
Date: Mon,  5 May 2025 11:13:50 -0400
Message-Id: <20250505065814-bd2b2904aeaf74de@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250503085031.118222-1-xry111@xry111.site>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

