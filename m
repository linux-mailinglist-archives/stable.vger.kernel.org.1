Return-Path: <stable+bounces-47891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E184B8D8B0E
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 22:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5EC1C20D0F
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8832113958C;
	Mon,  3 Jun 2024 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="DrmgVtNn"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F2B651
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447749; cv=none; b=sb4JkFJvIUAGUNxEWoOBV1qBlNcmC/a/hcwr0umOCfVLdvijOO1VWucU710rTyPENLCv69iuXoZ2gg2aTDd+cDjcg2tc34SZAC6zXOtuHqo0/Ulfck6qxJKO1Pvu110Bv3Y0RdnDjpckGMn5xUXm5KLSBMrGS6Aec7luDTDoJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447749; c=relaxed/simple;
	bh=WvIFKq/r/270nxZkioFDcAGAacdTks1k3mJZ9zWzo48=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OEmySdnAs7Vwfy0O+6Oh1AOVDOtPzPBc6eNbNi7xhSGKoaGt1GVsU749N3WBk1t6FGPUcjZwpoW2pG/841BU7JU4sH5MY4bZlF1mV50jVszZkYChdOM3TsrzFucHuOKzuO2gTpRGXajRLlMqhmuHOaLNe7GveKkHm6hYUtnd4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=DrmgVtNn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3737dc4a669so21227735ab.0
        for <stable@vger.kernel.org>; Mon, 03 Jun 2024 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1717447747; x=1718052547; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5NMHXwPcGaw7JTj1qfWppz0p1uraG4kphghnrhoKb5o=;
        b=DrmgVtNnGDdvrNwOOkKhuonuE4ZROt2wSubDZpZd+E8YVcJuUk/uRvCVpGWTkQAPuy
         tPfOSTQn60B8fkWhLa5ve6Kqsfe9WsOB8mvjJbNaJ7A6/+HCLucDRUlQ0hwFD/6bwoDF
         NR/hHtf03Dvx2m6a3qLCcDeosfaDkVk3nLVxswGzZFa55F4GgNkRaXF47sG8mSfu7VhL
         8AIGD0PNEE8P9EyRUjCfrRj5pLKrL02g49+aVPLdg3R8Hi55dd0njGvi37zM5+zIh5Og
         hombWE902+2/hGSvrO+NF0erI+b/3E5nkmRn9BajPzwg/37wZ78Bhkl+wefDLjHFQ+xf
         8M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717447747; x=1718052547;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NMHXwPcGaw7JTj1qfWppz0p1uraG4kphghnrhoKb5o=;
        b=IkOFf3oeOFI6J7ydhLUuB5Li6nhTXUAIWFUsEDdx/5dUL9tUFi7/Kpwo8A7TQd28vB
         TiqD8W79Dd/+QIoCgNlerrQ8ahxj3BLHDFMRYhTbfkg8ws1qP9fINSrJAefF+RYOCM3t
         KDHZbHR38cvo4R4KkGwT/0Cc0eYqswU243+GzK5R0g8VJoySx5G4TlBFxUFXf7uJt0lI
         ulDO6KiSF0YgVuVDxgIGMnjbwlCmhESihaZPOKCCZXUOFo97OZMuIiA1lrcDcsQOhJZn
         JC3IUwGP2s6Rm2zlHATlzspnh4QH9k0riFwgG2SXRO8XCh2R7us2JBVsBCmzD00qlnQh
         fjWA==
X-Gm-Message-State: AOJu0YwxeACXJDopBB5m4RB1J4BPrv5f1Iv7ylsTCk25BuS8uDd+Zbgh
	JfZ2+wgSQKMU54uqipxyccOZJNB4m6Ea6sZsdA3kFuPMKHNbulB7hThnqC7MXg4Wf9I3sDKngnK
	TPZ4BO4fyUAyscz0m88o5bQETSRob2nH1UpWRi3jgR+xQYqYSj2A=
X-Google-Smtp-Source: AGHT+IH1gIAjdyyru9BL+F7FOLPVE12mSX+Os5kaKZQMBX5nzE8br2Mv1GqtnGVB79NnI+ytND9jYIN7HvZWrzNq8HU=
X-Received: by 2002:a05:6e02:1d11:b0:374:9552:821a with SMTP id
 e9e14a558f8ab-374955285d8mr72871615ab.5.1717447746906; Mon, 03 Jun 2024
 13:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ronnie Sahlberg <rsahlberg@ciq.com>
Date: Mon, 3 Jun 2024 16:48:56 -0400
Message-ID: <CAK4epfz9B58Dfz=wwNP2PJQzeqvT3J_kjY9d7PNY_VPKDKE=dA@mail.gmail.com>
Subject: Candidates for stable v6.9..v6.10-rc1 Deadlock
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These commits reference Deadlock between v6.9 and v6.10-rc1

These commits are not, yet, in stable/linux-rolling-stable.
Let me know if you would rather me compare to a different repo/branch.
The list has been manually pruned to only contain commits that look like
actual issues.
If they contain a Fixes line it has been verified that at least one of the
commits that the Fixes tag(s) reference is in stable/linux-rolling-stable


56c35f43eef013579c76
eec7620800081e27dbf8
4268254a39484fc11ba9
0a46ef234756dca04623
ecf0b2b8a37c84641866
e03a5d3e95f22d15d8df
4d3421e04c5dc38baf15
9cc6290991e6cfc9a644
77e619a82fc384ae3d1d
e533e4c62e9993e62e94
21ad2d03641ae70a7acd
2afd5276d314d775ae0b
3bdb7f161697e2d5123b
6f31d6b643a32cc126cf


-- 
Ronnie Sahlberg [Principal Software Engineer, Linux]

P 775 384 8203 | E [email] | W ciq.com

