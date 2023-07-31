Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30747769D41
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 18:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjGaQzX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjGaQzU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 12:55:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1DC1729
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 09:55:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so237a12.1
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690822517; x=1691427317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FugYPAHRqw7Xfd9X9Niu54YBGcN++GZEOKP1LL2G8Uc=;
        b=YJ+Od+D4vmgyhxZkY79XUm127w4e8w49g4ygfWyf4S8Pjd6qb1uYFNRMl9a3lZCZP6
         ASae7VRxDmZZpyepRrnQ/X0U7IW/67gL+XQpIcKOGSIyS/C7urXqMaJtvEFF8ZWoXhVR
         4pJzWrRXXWE3r+kh3KGTKS+C4cNcQ6cCx6sLR/pDLPQUnvzyaDnhL/m46JrZck+4UyOZ
         wOwU2U7Dj3G8VJMy1BCTZktpc0SOcFqHvFZULIAaOiyhFkznflpbwD2yt0ez14Qt4mvp
         VGe8LmZ8L8bzy+Ps9QfWh87ilV9nlAhC+9GBea+xYhMgUngXumQNHyExz2iJ+sQZJitQ
         vQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690822517; x=1691427317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FugYPAHRqw7Xfd9X9Niu54YBGcN++GZEOKP1LL2G8Uc=;
        b=LcE7czvBbFq5nxg8d6KaQPKvoZh5yuSvJsNw9+VdtvrvoV8xWJLSb+R2K03G4mwS6H
         s3vZkBcSST8s+HdLq661abUFiq5uOvJ7vWNsq9ivkJW46Lb3n+FUUY9ycxkK8+8/4oLo
         1k5O+2PmpYzaIltJ1bKGnfaCZLrEKoyatBmoFstV8jt8jXXKZKq4eOlpcBTL7/p16nAl
         2gyAkm/Dd8c6VPV2Bgq+JBBzZu7sf3+XqJDK7wXB194DgpEI0MwHcQAWig3l3ppJ8PSs
         Srvsr533HHbi8xsyXy0roysWmVJguaFbCiXG/4rWsOa77VqQDTTe9fBtq+GM9YJt8hv7
         k6sQ==
X-Gm-Message-State: ABy/qLbpSDO03RBW/1AFMImQhmO5nvl11fofDPqkjx9yyAKkBT/1f5JM
        viPiQuIdkBQKybiejHgENj0OCdLx3iDKAiOSAsLuPg==
X-Google-Smtp-Source: APBJJlE+edF8TNpdCgDk8gTCgGh6lrPGkKMArrAU4l29oolUCrG7bc9wLzTxb7S9keGivJ1c9KdBhx9t+zYPVH+gZlc=
X-Received: by 2002:a50:8ac1:0:b0:51a:1ffd:10e with SMTP id
 k1-20020a508ac1000000b0051a1ffd010emr175599edk.3.1690822516902; Mon, 31 Jul
 2023 09:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230726020810.1408299-1-rdbabiera@google.com> <ZMeYBvD+I1U8HNfF@kuha.fi.intel.com>
In-Reply-To: <ZMeYBvD+I1U8HNfF@kuha.fi.intel.com>
From:   RD Babiera <rdbabiera@google.com>
Date:   Mon, 31 Jul 2023 09:55:05 -0700
Message-ID: <CALzBnUGH+jCuz+shO=G2O72gHHjwGe03WtXa2vmscsFvpC74ZA@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: set initial svdm version based on pd revision
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, kyletso@google.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 31, 2023 at 4:21=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> This makes sense to me, but couple of nitpicks below.

Will fix, thanks for the feedback!

--
Best,
RD
