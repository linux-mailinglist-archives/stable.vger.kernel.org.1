Return-Path: <stable+bounces-89057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5CA9B2EAC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0301C21324
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802741D2B1B;
	Mon, 28 Oct 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOvO4llG"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7961D79B3
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114124; cv=none; b=l0efOtZOIEjz3vIjB3to2XaBUJvcZujKzIgE3AMWXdkzi2vbj9dZ+gDC7UQCpkOW6zd6ughmdllqOkKp2V8iAIsB3NByWM/h4PK9rptJViUwsXUV2zhdJqvqLvmC1VV5SXj+vyvat2y99XA9QUdrzj5Est8GrD4jTOeDlHe7Exo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114124; c=relaxed/simple;
	bh=o40vLJF3BhZaPEsLLLDudzK2h1sDZMe+2JjzMNY6nBU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=StjvopXySZOnkWU/WcPOs+jRma1jG7LZho8SIu0QjM8dzohlsMVBQulOu+GjUbGxo7bC84vMaoYmPTYmy6ax9L4GrN67isPvIaqbaPZIw9ySPY8CekJi9qpftqt/qCwftAc9VgJABCnb/z3daYgJ2h5B93wEncbPmISJufXTelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOvO4llG; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83ac4dacaf9so147814639f.2
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 04:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730114121; x=1730718921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o40vLJF3BhZaPEsLLLDudzK2h1sDZMe+2JjzMNY6nBU=;
        b=KOvO4llGvPaR1c2rAGklWRUTkxvsHWOfmLdRWC/qdcHO+2SQnjxur7xj0oqkvqPeNO
         wPHhvGEHF89nRVeydJq0O+IMB+cmQpE3zspsuxBUJLkqlvH9N2eLRvuJIUsl3k/0fYMJ
         OUmkP5tDM2rsgSzpCFMMZFE7XJtJyUZG8W8P7uUUu5qm6hlxnDrBWYwEBhpFBUmNIcIy
         i6Ongg/TYLHcuc5MaiE8hFcW2whGvODiHm3lIfM7WN+prugqGDWOw2xMHk1xDs/XuM69
         uSoMI2N+vWAGt5siF/JQnshJehWCskjDsww//fn2ilIxO/yEEPGTU5nTstFrTDtLMWj9
         Xo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730114121; x=1730718921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o40vLJF3BhZaPEsLLLDudzK2h1sDZMe+2JjzMNY6nBU=;
        b=hknvQDQ0bVtO+fulRq9Kr98uZ4/k5pPUkKikjwnPoJy7UG0rsAqQ6oRK1CGYdTrGU0
         wXQ7gQNeH86GLFPW0dvNjco/tlaU66ZOp/4Lu0V7Kaeri0jq7tjZ5tIFkjCoaygtBXmp
         S0fX04rJ0EjYEmTWkgIFMSlbd3cCJk1qCgOA6JTJox3IlRBMdxD3b644ClqMUXTmOeeO
         7D2ZWt2wMhhEDS2k7xcFLnusEmjkVxbJlStLcY4il9jU0yLbPV7seO5YCw9IKFyM8GGW
         vtlR10RxZ3866ZOsbTg/I+JWMoioWUT9uWes8vf8K3qKsPkaE7JBAbSYnWhEefE9Ho8I
         HRQA==
X-Gm-Message-State: AOJu0YwmvKbkfdaMphSGlut1Tv65yXdjbKPu+poiTnWdlkhyleGLS5jz
	bA/qXoJVRo/zv9uNk4BHz51VGnw/HJlDHLokoyh2dLY4tYxDEY3AGUiabJ1MXJ5vjn3OT2ab6rd
	Tzt2RL2I9H2zMeJr5zSQA1+moAoYxH/nK
X-Google-Smtp-Source: AGHT+IGLdmWh31jtT64TtCjVtFG4zpYJXxVdqe86MxZJhnLUBdxBzPK009ielBNty80zQFy5wKN4MMegA9wKklLCdrA=
X-Received: by 2002:a05:6602:641c:b0:83a:a8c6:21ad with SMTP id
 ca18e2360f4ac-83b1c41a25amr618176139f.7.1730114121119; Mon, 28 Oct 2024
 04:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rui Ueyama <rui314@gmail.com>
Date: Mon, 28 Oct 2024 20:15:09 +0900
Message-ID: <CACKH++YAtEMYu2nTLUyfmxZoGO37fqogKMDkBpddmNaz5HE6ng@mail.gmail.com>
Subject: [REGRESSION] mold linker depends on ETXTBSY, but open(2) no longer
 returns it
To: stable@vger.kernel.org
Cc: brauner@kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm the creator and the maintainer of the mold linker
(https://github.com/rui314/mold). Recently, we discovered that mold
started causing process crashes in certain situations due to a change
in the Linux kernel. Here are the details:

- In general, overwriting an existing file is much faster than
creating an empty file and writing to it on Linux, so mold attempts to
reuse an existing executable file if it exists.

- If a program is running, opening the executable file for writing
previously failed with ETXTBSY. If that happens, mold falls back to
creating a new file.

- However, the Linux kernel recently changed the behavior so that
writing to an executable file is now always permitted
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D2a010c412853).
That caused mold to write to an executable file even if there's a
process running that file. Since changes to mmap'ed files are
immediately visible to other processes, any processes running that
file would almost certainly crash in a very mysterious way.
Identifying the cause of these random crashes took us a few days.

Rejecting writes to an executable file that is currently running is a
well-known behavior, and Linux had operated that way for a very long
time. So, I don=E2=80=99t believe relying on this behavior was our mistake;
rather, I see this as a regression in the Linux kernel.

Here is a bug report to the mold linker:
https://github.com/rui314/mold/issues/1361

#regzbot introduced: 2a010c41285345da60cece35575b4e0af7e7bf44

