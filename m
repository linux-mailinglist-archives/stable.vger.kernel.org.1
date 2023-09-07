Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1E7977B9
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbjIGQbs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240353AbjIGQbe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 12:31:34 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128B44B3
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 09:21:29 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so142886466b.1
        for <stable@vger.kernel.org>; Thu, 07 Sep 2023 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694103317; x=1694708117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPet9frFOlN+fq8ywCGgPEJ/UelzH3no+zjoxqo7e8I=;
        b=R0MVQ/cBSJmLgOgsRIfeJs+1IdlKTcwuu0OExS/U3Vk1rJnsh+qTPWXlxLr09KXiJL
         GOn+330kgVHW1xXZT/mUfbhE87T4fhWzqQtLtXNh+Vj2nZZdilBEVF+gAWaBVj+z2hZG
         Ge4nucyy0wnDMLEqhiE+YSx4Aaldj2QYLyfQW0rM6C1RWHNmSbZ/wG7AtampKGrGGcY+
         2RQky1ju+oqLhJtSSfr6T4VBQDZ+YXunH/HE7y4MhUJgR03CHuDgMoWjuIl6WS2htnM2
         8mN3YY4VXd3HJTSUAOj0+Dt2x0AM7gX+MmY4rqLimp50hDZ3kG3GrmsvwRm8HNOLxutf
         23lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694103317; x=1694708117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPet9frFOlN+fq8ywCGgPEJ/UelzH3no+zjoxqo7e8I=;
        b=ulxfkaI79pLbaXNvoRagQdlR1wZk4/mNcQ0TsGBH5p1CM5tyNy4TlzFEJHUqg2mnZT
         /HWuFoquTNPmKRSfEakabYSQic6dZu3gsIZLCJvR/wCKTEyAcbv+SjDM9RJanPP6rWQw
         9OaXcssFG2gUlCYTSXsEuVQ2efQLSkrxLM2+TMwuia8P92RX8AOh1cfl3xVrtsJZpqB9
         ai0kzsWs8ecfmsEnI4+Vke8SGs5w7Y7W0WZgGdM/C1asfB0TshdaxUZXDkL99o7U6Paa
         j7QA4sLKqqkEOm75gbwqsCt4P3zg6XOvQBEFGvjkFmxi11dHW3ynyAl84vPl+s2iKt9D
         4G9A==
X-Gm-Message-State: AOJu0YyDCcJ0UgHAWvGQraO4aHIoT8gxqMrTjThs2acb6zksPuf3fdLH
        g1xBo3SZVUX/0G69TDo/TnCMQ4git4+CQK0vvbl1Pg==
X-Google-Smtp-Source: AGHT+IF/NbTgNtmVVXa6cyt4x/KYgk/3Vvk2bF18WA78zm5uinZw4btDDtKc0+oY5sbqk+/zrkgrPue1IaBpjjVsvgs=
X-Received: by 2002:a17:906:535d:b0:9a2:295a:9bbe with SMTP id
 j29-20020a170906535d00b009a2295a9bbemr5111180ejo.17.1694103317070; Thu, 07
 Sep 2023 09:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230905235846.142217-1-jrife@google.com> <2023090743-cheek-zebra-a175@gregkh>
In-Reply-To: <2023090743-cheek-zebra-a175@gregkh>
From:   Jordan Rife <jrife@google.com>
Date:   Thu, 7 Sep 2023 09:15:03 -0700
Message-ID: <CADKFtnRQ-gZGOh2Qj+gcG1oAGgR-J_r2mh14JRCCHD0UUcJubg@mail.gmail.com>
Subject: Re: [PATCH] net: Avoid address overwrite in kernel_connect
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> Nit, next time use more sha1 characters, the kernel documentation shows
how many we usually rely on.

Ack. I'll keep this in mind next time.

> Why not also 4.14?
The BPF hooks that lead to this problem were introduced after 4.14 in
this upstream commit (d74bad4e74ee373787a9ae24197c17b7cdc428d5). 4.19
is the earliest supported kernel version in which this bug appears.

Thanks,
Jordan

On Thu, Sep 7, 2023 at 4:27=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Sep 05, 2023 at 06:58:46PM -0500, Jordan Rife wrote:
> > commit 0bdf399 upstream.
>
> Nit, next time use more sha1 characters, the kernel documentation shows
> how many we usually rely on.
>
> > This fix applies to all stable kernel versions 4.19+.
>
> Why not also 4.14?
>
> Anyway, now queued up, thanks.
>
> greg k-h
