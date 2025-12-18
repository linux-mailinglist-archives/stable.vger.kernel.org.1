Return-Path: <stable+bounces-202915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 705F2CCA1B8
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 03:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41582301670F
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D862C21FB;
	Thu, 18 Dec 2025 02:46:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9D214A9B
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766025967; cv=none; b=UeZ3cdkjAQt3OaqlqXRCdsXl3FykIGWoZ5YWcTLrtsnw9UI0k09yeShZGR0Zoapm5Ammi9FgTznv73jf4x0Fp0MwOEMwPJ10yel7kruSL+Ac692pHUxG6rtm1nXH6eq8YATIP50E2TQ1vh3IvDDmm5yxZhGfWwcEkL4hcv6f/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766025967; c=relaxed/simple;
	bh=4y/zZ8jxS/YgRJOz8RjmfDvBzoC9sJtbMNSFwzLXqAA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gnc4xpe5xg70LZZPyWw9t4YIxQeruAozmi6apYpVRLqubibvMospID5l6R1NBT1dvFEgHdmjvMpPa7vt42h1XUH2vmPZafzpW+wB7fp3uvz42nbAzoNvwsXeJyAFLWPFC1lV/D6I+qvNtHyRVzaS+XJtlA3o9YQfVzLMInM75So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-3ec31d72794so2486791fac.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 18:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766025962; x=1766630762;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSO9yb2p1vSk90uXUhOeb+mECUdcMxxOCOnouX4N2NA=;
        b=HLV2+T447LAPi57p6iyCPK6/4XWaFv8Ln+VCqrX/Ad7V0jUE3TOwi2v1FvKSs8oyVO
         GTY9xI0ImhlILxU9I+xCLK30ITXiEAt7sXIgmQ4Jvgq1Xo44bddV+THzaBpMOyK38E1y
         cmbcHOO1voy/WPAigoAjWweVrqf8FQdBA68rg2XGfuYgz9errbU8unpM8wcj6IEHes+b
         mK//VsItXMyL5uDoMEqT9swk9VFET/0/rbODT2tfKNNHn2Uss7qz3eLvOHOUteaDtZFb
         /lzvV3LM0Czq9/gQZzSk5zf74Bi2wef3XkJuWqiEvGUII+cReiVktfbjqscrIFm9v1Sw
         BqVA==
X-Forwarded-Encrypted: i=1; AJvYcCXGtROVDyWZ2oPfNbfg3LlRxxzAOZEzPGWR9S3U2n4uPFdhW8t21s3ytoybQXsUxI6DgqxvFDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7onMvwC8oNxxdAc6Q3cxUARcgb9mw8U2xwfO4QpRZ+elYip/Z
	Z/AEIivfPV7q0CfGsFMnR8P9Dkz0HP9+9UCht9qKi0mvihgHCJiu2pTSYJOZIv5EXgiffsf05Ty
	EyRiId9+8X8cjWmInFjCCxIvTefolujaSwJp/Qhqy/vyUCJzAEG2Mg20bww8=
X-Google-Smtp-Source: AGHT+IEMbqrplQQ5a3Qn9ywA3mjZ69bpR8Hq8ieBsDYVWj01otiONiXFaktKeiL9VkP6L82xZfh9sbBkP4B/Fx3fOLV66l0698O/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:488f:b0:659:9a49:8e25 with SMTP id
 006d021491bc7-65cfe746e25mr482368eaf.23.1766025962671; Wed, 17 Dec 2025
 18:46:02 -0800 (PST)
Date: Wed, 17 Dec 2025 18:46:02 -0800
In-Reply-To: <20251218022439.44238-1-wangjinchao600@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69436aea.a70a0220.207337.00c7.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] WARNING in sched_mm_cid_fork
From: syzbot <syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wangjinchao600@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy binary to VM: failed to run ["scp" "-P" "1814" "-F" "/dev/nu=
ll" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "IdentitiesOnly=3Dyes" "-o" =
"BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o" "ConnectTimeout=3D=
10" "/tmp/syz-executor2977063156" "root@localhost:/syz-executor2977063156"]=
: exit status 255



syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1046867334=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at d1b870e1003b
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3Dd1b870e1003b52891d2196c1e2ee42fe905010ba -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251128-125159"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3Dd1b870e1003b52891d2196c1e2ee42fe905010ba -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251128-125159"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd1b870e1003b52891d2196c1e2ee42fe905010ba -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251128-125159"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"d1b870e1003b52891d2196c1e2ee42fe90=
5010ba\"
/usr/bin/ld: /tmp/cc3BBp1I.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         ea1013c1 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D513255d80ab78f2=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9ca2c6e6b098bf5ae=
60a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1439631a5800=
00


