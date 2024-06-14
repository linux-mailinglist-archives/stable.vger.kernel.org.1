Return-Path: <stable+bounces-52235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8C2909226
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 20:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51050283FAB
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8BF19B3D2;
	Fri, 14 Jun 2024 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="b/DMhRYl"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A817FAAE
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718388850; cv=none; b=Gq2tX0vBC3jTAW364HJeJmP6MQGdsjD+2uQ69r2doerUkgBZvC1XzZtQ/1E5ncJ55MV/VuRB+mt7RT2ODBhcyI8ALhYRQbiIgZBS7+mguqJRdVb0At9m4fBkBtdETHXh5E3UuEHarNL+Ev2jOfm1PclCAAgVcM/9gXcl2baJNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718388850; c=relaxed/simple;
	bh=OHUAskxWWAO8KfPXgkfrFWF5QNd7CTOtsUH17d3AEQE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RdXhJ4xAC6r3+GbORl2GJjPcI33VQJC0c7l5KRSbFvqIh72l6pYlnUi5TYMX5qshhlVD8ef/JQuNqAZXqXDemuwD798raORA/9ZxM8Xrt6wwTLhiE6kYuA4Vx68lEowElBqZhp7y0Un7bPYpLFBOQKZDzQHS2nIU1ySQKnTaOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=b/DMhRYl; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eb85f63f4aso111289239f.0
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1718388848; x=1718993648; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bo8wbvvAWLfzzmtdfITuscjEv3H940Uri/asrCsjenc=;
        b=b/DMhRYlwxYXyh4qe6S4Ri+YSP0aLpvP1j6vHbgXHXk/pJEK0JPm61dM1hyCQNOFAv
         15Rjimr+B9DjTv//z44xf2dsape4fJMJFtkC3UdD+C90Uk7CLW38mxyxePtQdZh6zZmu
         LN9L8XWiZ1WSN4V3nUAK6fBpDc+EGIc9zvtjDhU7pcH7/i4n8gIoLI8f1NlyjWoLGwVh
         0Tyjl8/8Ho5num/JijswHt9EouKv58IeW5NB/pF87k8amkELWcVoHnYgU+hKkVfmZR0W
         EkEeNpA7bNqlvGjy1SYsthnc/1A7MtZFl6zlbdZSyyd1/tjTUDUj7G1HlWM20WAubs2T
         3BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718388848; x=1718993648;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bo8wbvvAWLfzzmtdfITuscjEv3H940Uri/asrCsjenc=;
        b=UCsl31ilqImJDiyfPG3LDR/ZJtq8JkWU1mq1zauqB0UCtI2YqYyGwbdTl3RgWIRi69
         FAVNR0GHlQNJAcETdygGLSyICdnJ7pvNgegm8NY4TTmhV38kV/j3frR0FYxGbY88w8jC
         TFm+xRcUGo1wWjZYPxD+hMf3goZRwvb5SVdoCLfDbbrfEAsA6IRtrXTRmo9vmqk2AqAG
         +9mO6Edrkb65ixL7SBX8bOQEWGtYak5Ur9Ahs5lrpq/HVRgIu1bbG7H7bDESjUJ37ChB
         qf8ouK84jJSoZl+BxZJ/hKTn4V6GaDdOqE4pV768zkvmNHUoroYDsRFWkD1oYUfP/e3o
         FwVw==
X-Gm-Message-State: AOJu0YzysIJ90vBDfXnplQlSL2Ay8Ou7PtTgKjqRa1SX63JepR3Q6SPo
	eSwTzM8+tYTIgcs+naA962O095wKHNqw5TPcD6WhEfqaj7RQk3P7ZYNm2xNOsiYOMbqifMEecAN
	ql9jWRzA5QhtYQVzW2oulM+Gm1goegfKrF6PXn//HAYSxt2rq8YM=
X-Google-Smtp-Source: AGHT+IFtVWPAnmOFszoMZLT4ziSUkmYpCrlNmU0pVdl1se7nK4vDL56Yg5kp3RJNOKD+1a2asbCgO4mfWudcN0DER04=
X-Received: by 2002:a05:6e02:18c7:b0:375:a3d8:97c0 with SMTP id
 e9e14a558f8ab-375e02b7cefmr24958565ab.10.1718388848309; Fri, 14 Jun 2024
 11:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ronnie Sahlberg <rsahlberg@ciq.com>
Date: Fri, 14 Jun 2024 14:13:57 -0400
Message-ID: <CAK4epfwEe5vuSYLvn2M2hdpy8WxRcnZ063LKCeqp1FqOU=30kQ@mail.gmail.com>
Subject: Candidates for stable v6.9..v6.10-rc3 Kernel Panic
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The following is a pruned list of commits from upstream v6.9..v6.10-rc3
that looks like genuine kernel panics.

As far as I can tell these are not yet in linux-rolling-stable

If there are issues with the list or things I cna improve when pruning the list
please let me know

a6736a0addd60fccc3a3
79f18a41dd056115d685
8eef5c3cea65f248c99c
12cda920212a49fa22d9
b01e1c030770ff3b4fe3
744d197162c2070a6045
3f0c44c8c21cfa3bb6b7
0105eaabb27f31d9b8d3
6434e69814b159608a23
d38e48563c1f70460503
c8b3f38d2dae03979448
33afbfcc105a57215975
491aee894a08bc9b8bb5
d0d1df8ba18abc57f28f
ffbe335b8d471f79b259
93c1800b3799f1737598
3c34fb0bd4a4237592c5
ffb9072bce200a4d0040
9dedabe95b49ec9b0d16
788e4c75f831d06fcfbb
642f89daa34567d02f31
f55cd31287e5f77f226c
6ca445d8af0ed5950ebf
ed281c6ab6eb8a914f06
e8dc41afca161b988e6d
c6a6c9694aadc4c3ab8d
eebadafc3b14d9426fa9
29b4c7bb8565118e2c7e
da0e01cc7079124cb1e8
b66c079aabdff3954e93
514ca22a25265e9bef10
05090ae82f44570fefdd
3b89ec41747a6b6b8c7b
57787fa42f9fc12fe189
1af2dface5d286dd1f2f
81bf14519a8ca17af4f0
991b5e2aad870828669c
17b0dfa1f35bf58c17ae



-- 
Ronnie Sahlberg [Principal Software Engineer, Linux]

P 775 384 8203 | E [email] | W ciq.com

