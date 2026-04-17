Return-Path: <stable+bounces-238524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMucIjm34mnb9QAAu9opvQ
	(envelope-from <stable+bounces-238524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 00:42:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF93541EEF3
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49C573060CAB
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3E348465;
	Fri, 17 Apr 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGcV+XYR"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DD371068
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776465717; cv=pass; b=AHaivxEIy793vUYinGLBClxQLhp2XNVgNW6VX8fpecat2drG9Y7xZMe3F/IUsP5psPNVUvi5c1+LF3pcQiO/uWGKVBdPBeC8CZ13iVhDA5PtJqCFp7xtlgmhfKrjvuQZSvO/rjokx4m1jn0dKoGwdOrmFVU+SepoA3Y8YrsSWgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776465717; c=relaxed/simple;
	bh=/YD8yp0xWKwI2D2OtGnCHdTeUAuw6QirUv+ahBuIzLQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QpHmqcfgoW9Oz1l/SI6l6WZpYOR/4EsVryDBXh3AIiaMfwy0a+Rqll29m3ZT+zvsN5PBUeqFmOYLPM+NErkoHRCSjaA6QusSOr+x/16r2dWV7ayEhP4g9NFk3u+ZKW8P/u+b5dKM1OZa3EK/yX0yz362ph3sZbD+nOVQup4aJls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGcV+XYR; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4e9697so1512c88.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 15:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776465715; cv=none;
        d=google.com; s=arc-20240605;
        b=WxbCrj3yjkR9WtAlmpYafHqIL9uYT/4IA9KNkex497F5ucmtr3KkNmu1PykZi2T4Yp
         W4e1eZ8WF3uz2+3GQQ+f5ND23w+s1CeZPKCgIP2lzNYsAbmmXb5WLm/im5lMbsgL6n84
         +/iz9Ow32cy0ZqTTi3LHlSl7PSf11nKEOdd9f9VHjRRxvHz7D3MQ/jGPNJHQ1hiU47Lz
         xd6Nzi65qSlZsYZH3tjuGFq6/fOVahwl1Dta64bjlXS0RajoQmmED82uelnx5VvgYYN5
         lH32KYXmh+T0egsJXweTyIM8VqftM2DusyoL6N6/DoMBT6AeZBBaCHpR8E6NLNcwHPuq
         2SaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/YD8yp0xWKwI2D2OtGnCHdTeUAuw6QirUv+ahBuIzLQ=;
        fh=9p4NP76Y+vWQ/uJVYA50nGMW3wZBbJ7oaVJxkrzNXrc=;
        b=M5fftYIBomSK5kmSQFTksKZzz6csyInMnrb4MbDJCpfEn3bP6eRyAvq1XspXtH0d6z
         cYrkcthH4ObtfdlN1tqXoRcyjvuMLUE2GiUMgmyFEfiLbKR+upzNpWRii1j08TPdd3PZ
         aS8VBPAuOVz5LXwlAYnQjy5THusfCF9w61V+jdLTdv+vexz+mF9IMDL1En30kpIsqCXC
         z9Q+TlIA/2x52j68nD61eW3aMWUROnwqKyy5vYEOJhYijPmtiH6yllPhAJZW8GTXK/ga
         F7T27EglIg58xyr6AO0aoZl5Mog9IGshL50f3/4cJmpaHaq/prkJ1aVL1j+MHHUxh8r/
         /Mfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776465715; x=1777070515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/YD8yp0xWKwI2D2OtGnCHdTeUAuw6QirUv+ahBuIzLQ=;
        b=EGcV+XYRUp7YA9//WBso7Ku58d1RDruMT8vR3yark83QysVwm/911Uu97AkQ9kWVJJ
         xNiz9KnLsGIZDdshZiVxU9DYkoVQEkzBVmHjWlO4xBrW3AuZ0NMbZKI4BVrWpuunruAU
         dKjNg3zsONpiVmr+xnJi4kzzucLCG06mUnZdNofiXjpN/5TY/hkmKy/Y/hK9ZGyXgUPM
         q/r28ED9OdcJ7t4PfaAHNrZqInpgHltuAbr51eaSvic0WOKwBTayzkP1aCJAul/ylYZL
         mMqSHzV/DTHj4lxvXFBhpRWB6I3kqvtAMBpjDbqrPFsDwgF4v/vCt3OJhfeAi1piMVQw
         1a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776465715; x=1777070515;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YD8yp0xWKwI2D2OtGnCHdTeUAuw6QirUv+ahBuIzLQ=;
        b=Yv6Wad+gnWTjkZptP37/8WrJzqaOZQ2Z50+eJyEXsHVk5N/Ye6Q9aMn0Ri2Ar20D4l
         k8KaVOL1tq5VPte4Gbr2CWlBfFfLYP9pxDQlZmNveE7bGnqULPpos0NqFmfBvDqjM7a7
         92PBlI1d/HnIzkJ1EEC2lBo48zgSGWrxqDyFFSlu0IYGl7Vbkn3fAKRhtX1GaSBSPQF4
         LatYOUj8lGwxOfj0C3as0Vq//H0mV2f0bo0JRZ+rIqrjJCCSVEfuHSssl1NN5iGX4nsr
         nBVNk1HNPX3Rq0kcJR/whdyskl0mQHL8msWa4nmSrstqDxl/dvcgb64DXxe5/XsYmuZM
         TYQA==
X-Gm-Message-State: AOJu0YxVOVjqdtB9rb1r/nNhTSszpLHVfwPOcO/AnBrb3E/CYkw39svH
	xUz1CfrG9ImGjA2XetyUX6aIY8mN8e0abXmlm8jyWDe+NlrwHsXTOFAN9Jsu6aoITiUzbWTxRPD
	9jqK9oUkCu2mkWOqcu/HBj2qQOXA+5O1m/J+FSpNq1GKavGL/JHOnQPicf9o=
X-Gm-Gg: AeBDieud3Wg/FUwhCobTTlApsA8N+S+jOMwCFANoTjp3MUBKZqxziZWFwwGi7AZR59G
	oaoeKXM5GxKfThRSS9B014PWHo7OgZtxAWAFSmIAexjkc8m0hSlwBeLXkAQMTXIevgnve6PsftM
	Do36Gowa4v5AnQPS062KizPikkC1zsmE+b1mz95qoyd9EaHcJ5s5UuywcAuF78QR6V8+b1xv4sC
	4LPS28Lq5bklmw8zVOhtymg61Gc7PvivF8+ZhFJwozTz/Xq5l+BSjVD1Z/hhhvCqe+Vn6G/EQyu
	pOy6p/qEd5dvAWaTPbWQyl93xVQ=
X-Received: by 2002:a05:7022:3897:b0:12b:ebb9:1aa4 with SMTP id
 a92af1059eb24-12c7b2439e5mr16861c88.11.1776465714573; Fri, 17 Apr 2026
 15:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Derek Taylor <ddtaylor@google.com>
Date: Fri, 17 Apr 2026 15:41:42 -0700
X-Gm-Features: AQROBzABZCgNufzPUq6pOEIfWP4LIaA5TVHKwGDxnLvjf8jBv-5uXGiK9xMJBhk
Message-ID: <CAHWLEDHfXZScF5jNDzgOxGXf-MBDcVNtqW0DbNz8Ra8rtcuL+w@mail.gmail.com>
Subject: [REGRESSION] Return change in 6.12.80+ with volatile mounting
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Kevin Berry <kpberry@google.com>, 
	Chenglong Tang <chenglongtang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238524-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddtaylor@google.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF93541EEF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This change seems to have so far affected at least containerd in an
issue reported here
https://github.com/containerd/containerd/issues/13250.

In stable versions 6.12.80+, commit
6c0cfbe020c0fcd2a544fcd2931fbc366ee3cd12 with the specific change
being:
[*] The mount option "volatile" is an alias to "fsync=volatile".
In this scenario, code relying on checking "volatile" will now fail
due to the return being "fsync=volatile".

#regzbot introduced:v6.12.80

