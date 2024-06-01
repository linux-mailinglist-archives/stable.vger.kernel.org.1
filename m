Return-Path: <stable+bounces-47824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BF18D70ED
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 17:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5F4B218AB
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E551E4AF;
	Sat,  1 Jun 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO+NGscc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B61111AD
	for <stable@vger.kernel.org>; Sat,  1 Jun 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717255925; cv=none; b=Miqtp61/qxReXWhpLb1ShR2MCVoT7gzOQmVQ0GwEVNuIJ9e3t9Wn6PwR39tSxd0S9o1o+1LbnvuNLbqVLM4aNZ3LhUYEmNSd0hYvROm2XeCDHgzDg/Qc/b7nGwnLB+bUivTmeKxNzWWfK7wCVACzpB1nEVe1vfOpNgxILowraR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717255925; c=relaxed/simple;
	bh=HY7w27E7EdnWFgWSJLfHNhZNeKilScoXqe76eDUO7yU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gBxlk8sHnLd4+IKxvYVE3rmPQFSs1lMnERedNVtzQykg7r7zPMnil628IDdEjXvUWhm/PK+xLiZmjlpw5aushy1zZMjfbW8DzRpcCsfaTbptN6XZxUj9n54Vfuw2VO9oi2U9/uGMM6MpNYlUEOfVr5t9UQ+tMINYQ7tGDpuXxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO+NGscc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso2387513a12.1
        for <stable@vger.kernel.org>; Sat, 01 Jun 2024 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717255922; x=1717860722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HY7w27E7EdnWFgWSJLfHNhZNeKilScoXqe76eDUO7yU=;
        b=NO+NGsccJWb1eZfQ78nJDNQH+msQj1JU+VTwjr45N0r1XIrTsC/2SaKRBCBZcNbMAy
         LkOk9GAbtPEIuCUjpB0JPK/jlZ5xDC5/mhVdqaMYCmGa1qpbABwZ7sMOft17nuOQekwN
         2/ZdQFwyNsbAPkdgDc/x4cfoyGq6dFLwZ/luhz8jfymxdSYqZXhQj12C7RqjYOzicYS3
         UmOQlNn4u3AXun8SokNAkHcF4l40mn8sTUaDJaaaEELzJnqCMfsNLX7ZoMHHCUwdA6NB
         IWoGWJcmQh4L6TzYuTrugOkcKOwnrEOjAaIxde6/GGIW6gHd8w5NFmFks8VOWPILxe7+
         7SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717255922; x=1717860722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HY7w27E7EdnWFgWSJLfHNhZNeKilScoXqe76eDUO7yU=;
        b=R5RscIL126wU9fH12nkT2MfA/AVzSq/LMF8UlVYYACrFfjWf6Tr4mjsOwgG4Mibr69
         7ejMLroByvZJpp2S0Wxl+M7juUQo+SWr6DOF5Kax1g6wNoG4sMGC6MysBsKDzEyBg5Hw
         Ki1pehyRwh0iLoYa/CQJKbDhRyallrj9n+yMhsNiCV1gS7jf7b7enkJZjBaesI1KSfqV
         w0jBh34FgVQ+Z0Kb9IKmQxfW9isUObbvHirlZPKDRSM/Ve3DnS6XwFoxdAQIlD6lVxeN
         8Ybk+KKM8wx7Ej7Zs0Tn2irxsJSdZ0ltRyFTG0WChsb554n2dlZASS+UYS4ct7HSSsb0
         hk0Q==
X-Gm-Message-State: AOJu0YxpJS93qkTAq6D0EZg+98n/7Gr+JrSzi67c2evOUlTgXA6tTWSM
	eaY+78US+iYOCUf4vIIYoYiOLzRMxNlbms/RHN3NpWmB2VRNMPqjeTHkFw==
X-Google-Smtp-Source: AGHT+IEpTNsGBefj50FQcJjGVtMM4v2ZRMX57x87BT3A4rEKy79vmF50v9cxTwl5Yiyj8ZtLa1zoWQ==
X-Received: by 2002:a17:906:1645:b0:a5c:e9e4:99b8 with SMTP id a640c23a62f3a-a682234d032mr308304366b.74.1717255922491;
        Sat, 01 Jun 2024 08:32:02 -0700 (PDT)
Received: from max-desktop2.localnet (host-62-211-193-15.pool62211.interbusiness.it. [62.211.193.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eab85ecbsm213922966b.173.2024.06.01.08.32.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:32:02 -0700 (PDT)
From: Massimo Di Carlo <massdicarlo74@gmail.com>
To: stable@vger.kernel.org
Subject: Maybe a security bug
Date: Sat, 01 Jun 2024 17:32:01 +0200
Message-ID: <2324886.ElGaqSPkdT@max-desktop2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi, I hope this is the right place

I think I found a security bug.
I have a faulty hard disk and sometimes the system doesn't boot
but a root console appears.
it's already the second time and I didn't think to take a photo.

I'm not talking about the control D or Root password screen!

A root console appears directly.

kernel 6.8.11-1 manjaro 64 bit



