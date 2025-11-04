Return-Path: <stable+bounces-192302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82250C2EFC2
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 03:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4D63B7C89
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 02:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405B7239E88;
	Tue,  4 Nov 2025 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isO4OK7B"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF91DE8AF
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762223751; cv=none; b=UmVdGyC36GVbeamaazMKteNP5Zawrf4jCFvaznmt2M5VEA+StPMI5rgMD+WGkTyHAtm9wdsEquVYlE67lJn1IrKw3fvf5TxGuUW8xiDDYqzC2DVhvbhm6rIuQzcXVg1gCml8yWvrNV4grkpyaa2ny6Ulkl5LXD2XnAOaPekioPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762223751; c=relaxed/simple;
	bh=5qohOmfVOlHXdjS8V5LvK7HdS301pXdyYiloI/NpKcI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FifRF4HQmTmfoCeZAGsiC9XInYXrfKInOJz3zm2fMwKkCzVFINC/2z/aKPgGKvWnr+If6/EWGePwzPcdHME6AkT2M7Zjn8ZDFpFkTWKqOSmub2HMyZQ8fjYvm/UgWT8ETz3BLkoKfa6a5hIpLcicN2C4k7tz9niqmAQRou+cRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isO4OK7B; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso1004741666b.3
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 18:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762223747; x=1762828547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5qohOmfVOlHXdjS8V5LvK7HdS301pXdyYiloI/NpKcI=;
        b=isO4OK7BNEg8mFnArTEnsHX+JdmYFePoO6SB8HmHUf5tcDMlUuPGpP0I3ZvLDaw858
         yPwQwMNzO1LYYPbjQlRiw6+zMSNr16iTDCvkdo/IBgC85DFlcYwMiAb+nNeTXVYnIHF5
         awNh6uMeY5moegDtlq5URU4RRCfnXHLfAHP069IkkqJdeJSU6GGnt4rpYExZI/Q8CJJC
         bkxQT08gx2MnmbRaEnZOxclYjs9LfV1mI8yEfajXw8SfdCnL7kBAm34aGHUvmeQLOZ2d
         prId2BCsVwwcNvrYhEi/v2oWj7BSBLbiXlwl6QaxUb7Dak/6XFlu/QGenPxMvNG79XsC
         KoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762223747; x=1762828547;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qohOmfVOlHXdjS8V5LvK7HdS301pXdyYiloI/NpKcI=;
        b=Wr69rxDxHWTZyJvuFMxHD1NOUbu5kI35s7wNiXa5iTuEJK7TF/Og3ovE2npH6qmL8O
         IH08FniCd9fUKCzyXB7a08tQwLrVtR7goCyBLMW0Xsohq05XvhqJBeOXl0t7E9yVq/ni
         TxZz71k6VzmZV9oB2xtJtdeZ9n6cvD0rib8V/W0j/ZiKd9KhRu+YwvV/anSv0wQrbl01
         qKjMsOJ9wcsd/Gegepotm7Ou1mII69OBmO4MpRkwcrI7lZCAAs/CxKClAj8ucK3tkgtY
         Ck3F78gjskH90dVVSUTtxuuMtGnrCc380zIqZ0LzZsIYwkGb6W3u2Qab3lhhg2q1jq7k
         YEVg==
X-Gm-Message-State: AOJu0Yz4z7gQyJ5DeVuyMniXuJFw4ihT9YeNNRwJ1Jf/VCGTJTlNmv99
	3mVbr9iRHjWY6TzqiJ0OiSHjnW3JXF4cZx3fmjWyDsqjBAGmSJYQWPGuwjGvNLXaloWNxi7bkw5
	neHb3GDlQKjm0WveQxMMKqMLV65X19oxGw3ym9Y7z94V8zQnbv846gAc=
X-Gm-Gg: ASbGnctXBqRYfDbYI3MQfxY90OiEGGbGS4a/0oSdKGpjJY6vef9zTeqhyxUasHd4dv8
	kfcY6wSphWH6FZswTmr7dGZlyY7kzSQhWDHUBzAMmrPTUqfskrOTvVAi6kL6RYVII59xxkQ12sX
	TPW8wnwpvS+6u6RAHJWqOv6GBVMB1F3hE0bh5lkBWON1Sofq4rXKEeLCpcCTtjHY3XHqn8DjVnM
	BjfGYAUpJsQv3Mw8AsVQYkczuhquK6GnYz0qI+CyuGPJaBPGg+vfGUglZBwCBKExoISx2G8kCnJ
	BcNhxjRXoPhZfA==
X-Google-Smtp-Source: AGHT+IFYhisSLrySWFN1eoYGuW+O0Bg2FW+1+hTcDT45S48dFB3krV8NqlIhTFw9xbik2a0mxTxgmadM+JZgtnbnY80=
X-Received: by 2002:a17:907:3cc4:b0:b45:eea7:e97c with SMTP id
 a640c23a62f3a-b7070626808mr1565915866b.47.1762223746007; Mon, 03 Nov 2025
 18:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Stultz <jstultz@google.com>
Date: Mon, 3 Nov 2025 18:35:33 -0800
X-Gm-Features: AWmQ_bnw4_pxx-vZBU1I0iCqBHW6z_mQiTtEwZRQp7mLOX3DwW5tu_RowtrBXaA
Message-ID: <CANDhNCraMOo6ND7zHjyM+BmGAvqb1ZAzL7Wp4XX82GRDhdYovQ@mail.gmail.com>
Subject: v6.6-stable: Fair-scheduler changes from the android15-6.6 branch
To: stable@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Recently I found there were a few cases where changes from upstream
were merged into the android15-6.6 branch to address issues, however
those changes didn't actually make it into the -stable tree.

Specifically:
50181c0cff31 sched/pelt: Avoid underestimation of task utilization
3af7524b1419 sched/fair: Use all little CPUs for CPU-bound workloads

thanks
-john

