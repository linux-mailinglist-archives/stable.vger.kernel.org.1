Return-Path: <stable+bounces-106215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773259FD5FA
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 17:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167801657B7
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060A446A1;
	Fri, 27 Dec 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkDofQY4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E083D69
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735317132; cv=none; b=BlmzMdK133E3qgFDevFd/9c4bQ2WfBNjap74gnFmgsqQWS53HureZ1i92utCqQEs9BJ9roqq+gDkltTg2QCTtWnAbFo9J0fSOh2CZRkj7tVwV7EbM5LOn/vnWhwYN+9POyOGEQDJs/sI7ZpKI0ISqPqdwgCVcwVsXh/d/0zSFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735317132; c=relaxed/simple;
	bh=/POqaoMycnPailKb5iGIq5BYI56uP/35Ww1d1xMljCc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DIGMHgXrQgsKMftqRroSxfgvlc9n7pYA9AFKjsP33wQeQa1Dchfgy64GD5t5HPGMSVtBoX1s5awG2HGGe0nMRZhtRf/kjKRoqkxdCTiclnWJTBU51Slr3OH4asoO6HBEpk8FOz3Srw+RlfDat374msQjq3TwT8Q2qat3sqCG1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkDofQY4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso12965959a12.1
        for <stable@vger.kernel.org>; Fri, 27 Dec 2024 08:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735317129; x=1735921929; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iu8VbXrpP/HDOdMoW5jj2DdE6NimNp0CawaFNcK1nJg=;
        b=YkDofQY4Ys0zxx3M5lKbYCRatOPFTF7tdDVh1SafseTApbfEmjfQJabZi4l87o4+pG
         CRWTFStz7FAyLNcYRajHoaLuIdCyU8iGJYdZLR7lxKrexh7on5VsfZ4R1cX/YjfgqwKS
         Z3Ehozv4wOodB3zzZB0RLeOa+5IZrUCLw4WE1InRb6oQtj13JiwtewQfaHxBp0UdkPh/
         1fLPwLJoM9zIYB04Z+sXTU7HfS9QycToZ8RvJpB3fXOTnZTj+duGHwDvPgJph5lRSwFj
         T40BPHx2uUvS9ue4ffIqUbvAqJ1t8rEJEsm1sSaZLb3btimrwk3MF+VM1BNAJMf8HfIg
         hJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735317129; x=1735921929;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iu8VbXrpP/HDOdMoW5jj2DdE6NimNp0CawaFNcK1nJg=;
        b=ZLyZPem5XpJ3K59L3g4JmlmrfsqCyre5NmZqVWUa17jRhxKykrOvMfsGN5o6ll3bMw
         dxJeAylY2iD1RIP3PMmNBx3pZLZ+kGFgdDvDzBmAChBcciOhGwxK75U087uCqXaAMWhf
         Ir4WreJ8NZHJyolv+W8A9QZlobGVQkC1ChS2FbRTJP9dFS2yRev9NYMP7GuRH0Cg5BNl
         Nk/m64td1a8NvA1OQeypNDAYcfthUDBX8UFGvCnAQSAwmcTQqTeU9CcySCnHv98IINVG
         gc4hOqYLzRDN7SbFqgs3GkZrGupFCOP8gZUPbyMrmOr2t1pq3hp4BQCXo6HYYEf9sz83
         vZFw==
X-Gm-Message-State: AOJu0YxesZ+LqjFGhtBLVtIpOqrTZmnbOmYmKDYtrS3o7sFXIsT5MSs+
	tPXC9RxwHvY+ESixA2uZxav6CHjezDBdKYOAvw7kqbje8HirHGCj0Q0WvBiqKMLzJ6S+gCkiJ+a
	cJFUzklPm5QzuLYQDebDzvIfmeLp6NfbOnSo=
X-Gm-Gg: ASbGnctioSd4400nzYqN2Ip3xsFh5kiIWsn3mdpNIUkKAgVxG14Eg8aKDPnjB4xcrSf
	rYGS4pQCSxZrnezadhKDkW21bRzonPEXeseBnJe0=
X-Google-Smtp-Source: AGHT+IHKB7CbN8mjg8QU/TqkMgeS4s8FzU8JqUdzdfljeUgZfgYyFbRBOORyVy0Ig6JX8+3LtzkzN6heMwf9ktrb/Jk=
X-Received: by 2002:a05:6402:3483:b0:5d3:d8e7:d6d2 with SMTP id
 4fb4d7f45d1cf-5d802388f37mr28435736a12.1.1735317128756; Fri, 27 Dec 2024
 08:32:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Eddy <mr.mike.eddy@gmail.com>
Date: Fri, 27 Dec 2024 11:31:57 -0500
Message-ID: <CAKYS9PWKgTK6g5TGJsCtLxL=oWsW1p5EZNASms+0ruQu8p8p6g@mail.gmail.com>
Subject: Many Rx Errors since updating to kernel 6.12.6
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

since updating from 6.12.5-100.fc40.x86_64 to 6.12.6-100.fc40.x86_64

I am getting many, many:
    kernel: r8169 0000:01:00.0 enp1s0: Rx ERROR. status = 352ac5ee

and some:
    kernel: r8169 0000:01:00.0 enp1s0: NETDEV WATCHDOG: CPU: 3:
transmit queue 0 timed out 5376 ms
    kernel: r8169 0000:01:00.0: can't disable ASPM; OS doesn't have ASPM control

Thanks!
Mike Eddy

