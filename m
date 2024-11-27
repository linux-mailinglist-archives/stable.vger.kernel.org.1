Return-Path: <stable+bounces-95577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 736139DA02D
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 02:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0465EB22AB6
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF7C4C9A;
	Wed, 27 Nov 2024 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKu/biGA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48C4437
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732669584; cv=none; b=ZDc/jHwASJf6zGqXJm1LlcOoWDRG8m4CgAQJH5OnvrBC/JdCXIb0aoA6/phtY/U3v422OBngdQpYTAp+AYTPSwbeuZFvLY85nguERpojyBTzzM16VjwqC44sl6JpPRCPTTsXatNFV+DuElkrrnS9nvRHMceAwDgYv04XjXBTISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732669584; c=relaxed/simple;
	bh=apqk7eWdQT/BnWOcYs2Sd5DK68xWQNPF1xvBFhFZotI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RyWBqaNApPat44RNjPDcqygNLJ3M84jyf4VpcaN87u98h9skhTVW2nHDAXM6n4Un24buqO7OPjjR1ksPIjcKyCrVhHrtyDm8LFdo1s8Kg4M8ymkXyUj15dHfaK3sv6M/b51Htbq+DWRT42b3rNdFbUU+C3Ha7XyVTTn6VNjmAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKu/biGA; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df119675dso49698e87.0
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 17:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732669580; x=1733274380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=apqk7eWdQT/BnWOcYs2Sd5DK68xWQNPF1xvBFhFZotI=;
        b=WKu/biGABggtA1MQ0A5CjnOjcjsok5prRAfDGBSyGhxAEio1LW3p1jyYaok29A4xyv
         b+xDKOPHRWvzXYgW6ofS5kcCVeMFnVxLmnCKFKcF+EWE/hv8gsRPPPj+0DywAthQO0Ip
         HCUifyHllKEt8f8KissphERh/dU7uwuLkq75ufcxmaChOVDH6hxdr9B0mhQ6UhEPHN24
         sH06wZ330z1pj+FwyYum+uHKvujs0YFyvf3VcgZQa/UULp+0Aery++E11xBV1jLarqso
         rtcPl/k4M9/jlxZk6BLNRNnhZX1eA/BXUhO7QLjEdup26kUGT9UZswkvrcddT87y+cBI
         Pp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732669580; x=1733274380;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apqk7eWdQT/BnWOcYs2Sd5DK68xWQNPF1xvBFhFZotI=;
        b=qA/VTuPnzHtKnNTJmO8inV701RB2MY0eu7RzHEcfrd9kh+8IR8Lq7ksz97e2ApRjhy
         RNqDgvl0HxPHLaLvJmjND4LqPjQiGaQKH/p9VUSrLxRUiTbgwEkgSMCA2Q0fiZQKWGWy
         MuZsK8SLUq+kbeNad+roeHZ3aSUdPR82TaZyKwuDA5Ziz3V7FD2h59B2UU3sTZB0s6iK
         3KVgDwuqveUYsuuAjXXssQNyioLz+LqPcY40vv2ZolbfRYymgDq9UeYUm9ic5vo0MrDn
         0z7mdpAYqFv5mswfaY7MmNBvcEEzvu6RD4ss/uihptYBepPTQvT+4RJzqVgU8/a2hyEl
         WB4w==
X-Gm-Message-State: AOJu0YzxGLyj/AbsMSBHtPc1uiLv2wmTQmbW3XWJ6BYp/S/zsyV/tUuY
	GZLAwDI1GDdXoDA6eO2LuSinDTjXfx/XFek8wqKC60sxeoQKw0I7B2ru0sS9NYbUyPWU4IoBbOD
	uJ9+/WjgJg1ZsOLpsopJi8SGHOVsvwcWtwOlq7Euel8hVktt+6z2v1bI=
X-Gm-Gg: ASbGncsPxkzLW61auvovhJdgE+ZqZ3TbEcsJk3/L+ofelY3rqKhLnFAoc9yW4yGgCxM
	GUxu+aN6MDzUpmsIpZ3G2Yo8D+Z/8qgN4lHRTihz17hnW7OLV6cAlVYrzFfojEw==
X-Google-Smtp-Source: AGHT+IE9e4awrAhEM085VkaC6dI2lcLLeY349Nh8qbh7+uf1q4FhCelu9cxIsfC8kiQi3fxK0hf2OQCeKa4xCMc5Ac0=
X-Received: by 2002:a05:6512:220d:b0:539:e65a:8a71 with SMTP id
 2adb3069b0e04-53df00dd2cemr500956e87.34.1732669579767; Tue, 26 Nov 2024
 17:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Rosenberg <drosen@google.com>
Date: Tue, 26 Nov 2024 17:06:08 -0800
Message-ID: <CA+PiJmShthadiM2ciL_NMU-K=jXEZUB0EztcdnKnFWOz3OfOVw@mail.gmail.com>
Subject: f2fs: fix fiemap failure issue when page size is 16KB
To: stable <stable@vger.kernel.org>
Cc: Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"

Commit a7a7c1d423a6 ("f2fs: fix fiemap failure issue when page size is 16KB")
It resolves an infinite loop in fiemap when using 16k f2fs filesystems.

Please apply to stable 6.7-6.12

-Daniel

