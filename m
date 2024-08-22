Return-Path: <stable+bounces-69892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A2895BA8F
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 17:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE13D289698
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0E91C9EA9;
	Thu, 22 Aug 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2FBwq1R"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C12C1B4
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340929; cv=none; b=U6XZpNe/LIb2lD7M7OnTCf17mBOtHqfEouqQur8vQGC1ranvU7HiKrMpoLmP2qCvsSc8YZRKB/5d4eZ/sgixy4AhwfVb69MGR+IVSqNKfMZYaBvxog1kp1e84rvV6eqzttXNjPPR6KziwozOPVrkMmg3dwloZPnq0OaSRb8pTRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340929; c=relaxed/simple;
	bh=Z8pmjH/Bk0P7Rxvcgi25lJF1QvAO5q1Gji9c4k0ExXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ac0+lxwV8exMGExMloWwGu7/9XWRAq+rbVIh/sN4xqoaG6Ygq/6/qC0l8cFt/SdH0o6H/mv9a2qEfkfP8zBk7801gGoxGQSiGzCaU7gN6yvv1q3biyZYKytndb1NvVcuQv4gFrOBbiv8lH/N9STydF088CnDKHEJ5+YsUhhGxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2FBwq1R; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-842f91f2545so276747241.3
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724340926; x=1724945726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8pmjH/Bk0P7Rxvcgi25lJF1QvAO5q1Gji9c4k0ExXc=;
        b=h2FBwq1RrBKLMbP++bmKnZc1y10Ys2ga2VYw0DewISPaJQft6o5pUmLWijNoozsdgR
         Bu3aqVKl5lkpOKyc8lqbVLy+Hk0/GrvA72ckyeBzXt3lhKlbs5oAIBJ7xWD5jAnw/Z5T
         SGm5YRN6ff3WKfxbOnJ3xis+vALJXnlFQ3QNKbt7Yrw7Ly8SmqjtiDZsUf/zy8dWb1bb
         X6CNPAUE5bhczWWmMcVSnWK/hZvML8h7CVLQ08UTrQqHI7DDdrKQVi7vesL43xf8/Yfv
         3EhcGOM6uiWgOBzi2xXmsbfOF+QjMt7m7A2nlHk1ZrCxK+lWZbB9yTzmfVs0DYqev4mx
         RIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724340926; x=1724945726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8pmjH/Bk0P7Rxvcgi25lJF1QvAO5q1Gji9c4k0ExXc=;
        b=IsV1EVe4yLUXCKWrQ1I14x4wNjXUQdEIAJQPkcZlDZXlHpaJsxHZRxgxjxmHZVzrH2
         wsLmfKaYDWQcNIzpskIa0spTqBtg+9QMHSrr5m8xWd4vilXFy58AROVgUUKut31rzV3P
         7HzaJi1WXwaHMmtQ7TnvHAvGM87gjRxaYQlLnJ70yH0SXpcSBw1HzHiITtIIdEbg92yd
         QrNGNdm0EASDNlDXdjYbyO53blamML3/gw9t/iqiVv2D/bPVsfoArozTVe+fh1CHAnpa
         8ZVUenZBpkrCFuEUtuV4eFB9VxjwYGkRnSQIMU+bg6D8OrB5yvFUtptqr04gRE5XmhHk
         1MXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnc7AMVuM5ouAdvkwUlDB9nY3u3TvoR+5JmLzvJbJUxjVYc6SdyMf8baBlV+b4xu15/r1htLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dvMSDkwVQbgQgwuBQ3t5di0Z1IcVoa6sTqxV6AN5eZ6rfBcN
	01koHsay8Q5VunqjekZMgN5EWpVGj36mBRFAg959JIbyOcdKb07H
X-Google-Smtp-Source: AGHT+IFW5OIbceMv/4NATC9ZnOK3Z3UW3MDB5dplIb/hraWmXNZF734SrnUK+Qm7cCubG6VJSdA00Q==
X-Received: by 2002:a05:6122:3281:b0:4ef:5744:46a with SMTP id 71dfb90a1353d-4fcf1aed083mr7650277e0c.1.1724340926371;
        Thu, 22 Aug 2024 08:35:26 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fd0834176csm182289e0c.43.2024.08.22.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:35:25 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: david.hunter.linux@gmail.com
Cc: hshan@google.com,
	seanjc@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y 2/2 V2] KVM: x86: Fix lapic timer interrupt lost after loading a snapshot.
Date: Thu, 22 Aug 2024 11:35:23 -0400
Message-ID: <20240822153523.89387-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822152146.88654-3-david.hunter.linux@gmail.com>
References: <20240822152146.88654-3-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please disregard. I am preparing a series patch and didn't realize that the emails at the bottom would be sent

