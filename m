Return-Path: <stable+bounces-43734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC878C4651
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299DB288D96
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB71224CC;
	Mon, 13 May 2024 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ2bH1nd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725E2E3EE
	for <stable@vger.kernel.org>; Mon, 13 May 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621971; cv=none; b=gzCWyc/Omdq/3Cl+3Ka9DWQdtHC+YJC0XoE8am0Q1o0PK++Gnd/EfrEq07bZpJTnSYFxiJQYtK+PGbGsot5TYWo4y4nljAVLOxzKT3/2oPNxpVZCGTA1nJijMt3IhGOM7VFWHcahE57CAyK9DL7tzc1LZBx2h98splgQ2aSc/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621971; c=relaxed/simple;
	bh=h6dxtLoEug+Fi6jiiQH7cA9EIHCmRx5j7LFEfezFmI8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JWHEwtDAabHKuNuDiXRqI3vLSnh+eWftpA8zmsl2AOWRAu1jwVarosSjvMe7/n9A2T1Wgtdl1C/Qd2H16nHkTuaeyjJD/d5Gkjw5s/8FppV/fby50utycyE68Rggxj4i+OzS18hhPcj0YNIuT6UU9XjbjDdXImrH1GZiFcUYMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZ2bH1nd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44e3fd382so3813207b3a.1
        for <stable@vger.kernel.org>; Mon, 13 May 2024 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715621969; x=1716226769; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h6dxtLoEug+Fi6jiiQH7cA9EIHCmRx5j7LFEfezFmI8=;
        b=gZ2bH1ndmH24DRPLfvd5Qmkhv7jBSFDCM9mbKRmQ4oMaR5P0Gk+u3D2MB4K5k3ytPg
         hhN/G92h+p2ASQ4gjIJPNJgwX3RBaIzHyggEcy5E9x78oRQkApwzeVuWCKONQrgoJMwv
         akS20b+Z2vb07LP1zyQLLhwMrzeLQ4m/PE8/C9NfdeCZ/i0lL78muv+iPXfjv7y67ZyW
         0A2SJrZIlDJobll7GACFMfPiXPY0zL0C+IPC6/2Mvxaq36XUhB45RmaKxUryQZuOpji2
         jBKw+0jiCzeAA4C2rH6a+cWa/VCoBVbrTwSW7B23ucmoaldF8NJKA3pH6nn64YjJVy7C
         S4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621969; x=1716226769;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6dxtLoEug+Fi6jiiQH7cA9EIHCmRx5j7LFEfezFmI8=;
        b=NmZKrTsUsF70FqTEZC+HfZ7wclCvRV7ZhgvpwokiIfnBHlrpMk9tVFidJ9uyCy9mfj
         COVGBNKIL/3MS4ZzL948+y0E+NyELrqKBIjXjnsEwFMTVIoECLEQfWk5je5Pm5HiDdKg
         6dynhZXcB6yoQA1gFU4BKdAiwy1RDF8nTZSTrTXogSXJv6QMeqpj4yL3owbFSuXJsq1D
         zwvRnLoKss/FBtPTub5/mnSIem8Ed0bC/CAqY2c8TzcDz/tcLQ77/dIhuCJclD/Ijeix
         asRmPhihfZwkIDH6Abv1c4xNBhjwUScgf3WbY2h8kO1VXnuq0Ak24S/+qqVuRAXOaid4
         NTVw==
X-Gm-Message-State: AOJu0YyyBPhfy4qSMWQMf+8MsqQmRWPDmJ7aJbKIeEu4VCkcUXKpjW0v
	Dn9Z45N0mkiV0xfdtr3/ByoiU5s1wLNJWTtzQ5z23GSOuDBo4cw4NibKa7BQqF/kzmGuGvRPu2I
	vG3ldTpsgjxaNAzplyte4mhEQ2sKMX8daSiQ=
X-Google-Smtp-Source: AGHT+IG0yeHDETNCPsCsvqA4YB6YSwuvf4mgaElb/v2cW7RyAqlRjDTmFRjCpa+FIZDVna3UYvbweTOs3rzFjvr4XrY=
X-Received: by 2002:a05:6a20:551c:b0:1af:a5af:f945 with SMTP id
 adf61e73a8af0-1afde120db2mr9206496637.34.1715621969267; Mon, 13 May 2024
 10:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeremy Bongio <bongiojp@gmail.com>
Date: Mon, 13 May 2024 10:39:18 -0700
Message-ID: <CANfQU3y36Yz9cvh+1Vy4GTV9cB1PjwTMfoFSXWBdDmHMChRjjg@mail.gmail.com>
Subject: Security fix from mainline: CVE-2024-26900: md: fix kmemleak of rdev->serial
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please backport this security fix.

Subject: CVE-2024-26900: md: fix kmemleak of rdev->serial
sha1: 6cf350658736681b9d6b0b6e58c5c76b235bb4c4
Why: This vulnerability exists in LTS kernels.
kernel versions to apply: 5.10, 5.15, 6.1, 6.6

