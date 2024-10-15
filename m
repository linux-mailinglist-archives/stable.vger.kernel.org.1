Return-Path: <stable+bounces-86391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C831499FA7C
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 23:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197AF28132B
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 21:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCEC1B0F33;
	Tue, 15 Oct 2024 21:44:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6D1B0F1C;
	Tue, 15 Oct 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028696; cv=none; b=Jhdp5lvBiHRgYESmDDMRuK8upkvNzDlV+Wd7rKgQ4f96Xo0Hx9VSDhSF6Y8qkZ4dK8jH9AU4oeyQYs//rJRjEB3hLoljOxZhO7cKpOMqPhszDq+7Zf9H5qGkhU7E6/2PaYXlUCP3jOiKD/fQh6g9Xtx775RyeLtkWqVs1kT+Qhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028696; c=relaxed/simple;
	bh=suzL021ArH8NPBqVpYZtfnGOOFnNy7Aan+tLyjhKjh4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=kqhdAW+JBDJnUhAmcH90Zx1EZIN7dg8x2KVvD3J/GjlLRjzopNGxh0oRUWQjx4pJWSsMZzN/DOjH2UJTPKOLW4PPK0SziVLjFVgN1RGy8LiXD0NnvsHQNvU7GBRXBNtvT5vHXgkXNxln+vmVJbYX0XP7K2o9a/cdcI60Z3+GgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 44e3bc58;
	Tue, 15 Oct 2024 14:38:13 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:38:13 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Linux stable <stable@vger.kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/691] 5.15.168-rc1 review
Message-ID: <e0acaa55-2e49-e8f-4a9-ceb75caf5337@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Builds and runs fine on x86_64 and x86 (Slackware 15.0)

Richard Narron

